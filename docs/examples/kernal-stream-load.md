# Streaming a file into multiple memory regions

The plain [KERNAL file loading recipe](kernal-file-load.md) reads a whole
file into one contiguous block with a single `LOAD` call. Some file
formats don't fit that shape: a multicolor "Koala" image, for instance,
packs a 2-byte header, then 8000 bytes of bitmap data, then 1000 bytes of
screen RAM, then 1000 bytes of color RAM, then one trailing
background-color byte, all in a single file, meant to be split across
four different destinations. That needs a different KERNAL sequence:
`OPEN`/`CHKIN`/`CHRIN`, reading the file one byte at a time and
redirecting to a new destination address whenever the format says the
next region starts. This recipe streams one file into two regions
(screen RAM, then color RAM) plus a trailing background-color byte, the
same pattern scaled down.

## What this uses

- [`asm`](../reference/keywords/asm.md) - this byte-at-a-time streaming
  loop needs raw 6502, there's no builtin for it.
- A `pointer` variable, referenced directly by name inside the `asm`
  block, as the indirect-indexed destination address for each region.

```pascal
program KernalStreamLoad;

// SETLFS/SETNAM/LOAD (see the plain KERNAL loading recipe) reads a whole
// file into one contiguous block. Some file formats need their contents
// split across several destinations instead: a multicolor "Koala"
// image, for instance, packs a 2-byte header, then 8000 bytes of bitmap,
// then 1000 bytes of screen RAM, then 1000 bytes of color RAM, then one
// trailing background-color byte, all in a single file. That needs
// OPEN/CHKIN/CHRIN: open the file as a numbered input channel, then read
// it one byte at a time, redirecting to a new destination address
// whenever the file format says the next region starts. This recipe
// streams one file into two regions (screen RAM, then color RAM) plus a
// trailing background-color byte, the same pattern scaled down.

var
	fileName       : string = "DATA";
	fileNameLength : byte = 4;
	streamPtr      : pointer;

procedure streamLoad();
begin
	_A := fileNameLength;
	_X := lo(#fileName); _Y := hi(#fileName);
	asm("
		jsr $ffbd     ; SETNAM

		lda #$01      ; logical file 1
		ldx #$08      ; device 8 (disk)
		ldy #$00      ; secondary address: use this file's own embedded load address
		jsr $ffba     ; SETLFS
		jsr $ffc0     ; OPEN

		ldx #$01
		jsr $ffc6     ; CHKIN: make file 1 the input channel

		jsr $ffcf     ; skip the file's own 2-byte load address header
		jsr $ffcf

		ldy #$00
		sty streamPtr
		lda #$c0      ; first destination: screen RAM at $c000
		sta streamPtr+1
		ldx #$03      ; 1000 bytes = 3 full pages + 232 bytes
screenLoop
		jsr $ffcf
		sta (streamPtr),y
		iny
		bne screenLoop
		inc streamPtr+1
		dex
		bne screenLoop
		ldx #232
screenTail
		jsr $ffcf
		sta (streamPtr),y
		iny
		dex
		bne screenTail

		ldy #$00
		sty streamPtr
		lda #$d8      ; second destination: color RAM at $d800
		sta streamPtr+1
		ldx #$03
colorLoop
		jsr $ffcf
		sta (streamPtr),y
		iny
		bne colorLoop
		inc streamPtr+1
		dex
		bne colorLoop
		ldx #232
colorTail
		jsr $ffcf
		sta (streamPtr),y
		iny
		dex
		bne colorTail

		jsr $ffcf     ; trailing byte: background color
		sta $d021

		lda #$01
		jsr $ffc3     ; CLOSE
		jsr $ffcc     ; CLRCHN
	");
end;

begin
	clearscreen(key_space,screen_char_loc);
	streamLoad();
	moveto(1,1,hi(screen_char_loc));
	printstring("multi-region file streamed",0,27);
	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/kernal-stream-load.ras){ .md-button download }

## How it works

`SETNAM`/`SETLFS`/`OPEN` set up the file the same way as the plain KERNAL
load recipe, but instead of a single `LOAD` call, `CHKIN` makes the open
file the current input channel, so `$ffcf` (the KERNAL's `CHRIN`
routine) can pull it one byte at a time from then on. The first two
bytes read are the file's own embedded load address, skipped here on
purpose since this recipe places each region at its own fixed address
instead of wherever the file's header says. Each region loop follows the
same shape: point `streamPtr` (a `pointer` variable, declared once at
the top and referenced directly by its plain name inside the `asm`
block) at that region's destination address, then read and store bytes
through `(streamPtr),y` in indirect-indexed mode, incrementing the
high byte of `streamPtr` every time the low byte (`y`) wraps past 255,
until the full byte count for that region is written. After both
regions, one final `CHRIN` reads the trailing background-color byte
straight into `$d021`, and `CLOSE`/`CLRCHN` release the file and restore
the default input/output channels. The same shape extends to as many
regions as a format needs; a real Koala loader adds one more region
(8000 bytes of bitmap) ahead of these two.
