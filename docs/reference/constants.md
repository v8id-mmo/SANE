# Constants

:material-tag: [**TRSE**](../tags.md): same behavior as vanilla TRSE.

This fork predefines 120 working constants for the C64 target, covering
screen colors, the keyboard, joystick input, VIC-II/sprite/SID register
addresses, and the 6502 registers usable in inline assembly. Unlike
keywords and builtins, constants are grouped into tables here rather than
given one page each, since most are simple named numbers or addresses.

A constant's type determines how it behaves in an expression:

- **byte** constants (colors, `KEY_*`, `JOY_*`, SID waveform/channel
  numbers) are plain 8-bit values.
- **address** constants (`SCREEN_BG_COL`, `SPRITE_POS`, `SID`, and the
  rest of the register-address group) act like a predeclared `address`
  variable pointing at that memory location; assigning to one writes
  through to the address (`screen_bg_col := blue;`), and passing one to a
  builtin that takes an address parameter works the same as passing a
  named `address` constant you declared yourself.
- **integer** constants (`NIL`, `NADA`) are 16-bit.

Constant names are case-insensitive, matching every other identifier in
the language (`screen_bg_col`, `Screen_Bg_Col`, and `SCREEN_BG_COL` are
the same constant).

## Colors

16 values, `0`-`15`, usable directly or via [`SCREEN_BG_COL`](#screen-and-vic-ii-registers)/[`SCREEN_FG_COL`](#screen-and-vic-ii-registers)
and the sprite/multicolor registers below.

| Name | Value | Type |
| --- | --- | --- |
| `BLACK` | 0 | byte |
| `WHITE` | 1 | byte |
| `RED` | 2 | byte |
| `CYAN` | 3 | byte |
| `PURPLE` | 4 | byte |
| `GREEN` | 5 | byte |
| `BLUE` | 6 | byte |
| `YELLOW` | 7 | byte |
| `ORANGE` | 8 | byte |
| `BROWN` | 9 | byte |
| `LIGHT_RED` | 10 | byte |
| `DARK_GREY` | 11 | byte |
| `GREY` | 12 | byte |
| `LIGHT_GREEN` | 13 | byte |
| `LIGHT_BLUE` | 14 | byte |
| `LIGHT_GREY` | 15 | byte |

## Boolean and null

| Name | Value | Type | Notes |
| --- | --- | --- | --- |
| `TRUE` | 1 | byte | |
| `FALSE` | 0 | byte | |
| `NIL` | 0 | integer | |
| `NADA` | 0 | integer | Same value as `NIL`; both mean "zero/nothing", no functional difference between them. |

## Keyboard

Scan-code style byte values, matched against [`GetKey`](builtins/getkey.md)'s
return value or used with [`Keypressed`](builtins/keypressed.md).

| Name | Value | | Name | Value | | Name | Value |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `KEY_A` | $01 | | `KEY_J` | $0A | | `KEY_S` | $13 |
| `KEY_B` | $02 | | `KEY_K` | $0B | | `KEY_T` | $14 |
| `KEY_C` | $03 | | `KEY_L` | $0C | | `KEY_U` | $15 |
| `KEY_D` | $04 | | `KEY_M` | $0D | | `KEY_V` | $16 |
| `KEY_E` | $05 | | `KEY_N` | $0E | | `KEY_W` | $17 |
| `KEY_F` | $06 | | `KEY_O` | $0F | | `KEY_X` | $18 |
| `KEY_G` | $07 | | `KEY_P` | $10 | | `KEY_Y` | $19 |
| `KEY_H` | $08 | | `KEY_Q` | $11 | | `KEY_Z` | $1A |
| `KEY_I` | $09 | | `KEY_R` | $12 | | | |

| Name | Value | | Name | Value |
| --- | --- | --- | --- | --- |
| `KEY_0` | $30 | | `KEY_5` | $35 |
| `KEY_1` | $31 | | `KEY_6` | $36 |
| `KEY_2` | $32 | | `KEY_7` | $37 |
| `KEY_3` | $33 | | `KEY_8` | $38 |
| `KEY_4` | $34 | | `KEY_9` | $39 |

| Name | Value | Notes |
| --- | --- | --- |
| `KEY_F1` | $F1 | |
| `KEY_F3` | $F3 | |
| `KEY_F5` | $F5 | |
| `KEY_F7` | $F7 | |
| `KEY_PLUS` | $2B | |
| `KEY_MINUS` | $28 | |
| `KEY_POUND` | $1C | The `£` key. |
| `KEY_ENTER` | $F0 | |
| `KEY_ASTERIX` | $2A | |
| `KEY_SEMI` | $3B | |
| `KEY_HOME` | $EF | |
| `KEY_SPACE` | $20 | |
| `KEY_COMMODORE` | $EE | |
| `KEY_COLON` | $3A | |
| `KEY_EQUALS` | $3D | |

## Joystick

| Name | Value | Type | Notes |
| --- | --- | --- | --- |
| `JOY_UP` | %00000001 | byte | Bitmask, matched against [`ReadJoy1`](builtins/readjoy1.md)/[`ReadJoy2`](builtins/readjoy2.md)'s return value. |
| `JOY_DOWN` | %00000010 | byte | Same bitmask family as `JOY_UP`. |
| `JOY_LEFT` | %00000100 | byte | Same bitmask family as `JOY_UP`. |
| `JOY_RIGHT` | %00001000 | byte | Same bitmask family as `JOY_UP`. |
| `JOY_FIRE` | %00010000 | byte | Same bitmask family as `JOY_UP`. |

See the Known limitations section below: `Joy1`, `Joy2`, `Joy1Pressed`, and
`Joy2Pressed` also appear in this fork's reserved-word list but are not
usable constants. Use [`Joystick`](builtins/joystick.md) (which populates
its own `joystickup`/`joystickdown`/`joystickleft`/`joystickright`/`joystickbutton`
globals) or `ReadJoy1`/`ReadJoy2` with the `JOY_*` bitmasks above instead.

## Screen and VIC-II registers

All `address`-typed unless noted, so each acts like a predeclared pointer
to that register or memory area.

| Name | Value | Notes |
| --- | --- | --- |
| `SCREEN_BG_COL` | $D020 | Border color register. |
| `SCREEN_FG_COL` | $D021 | Background color register (despite the "FG" in the name). |
| `SCREEN_CHAR_LOC` | $0400 | Default screen character memory. |
| `SCREEN_CHAR_LOC2` | $4400 | Alternate screen memory location. |
| `SCREEN_CHAR_LOC3` | $8400 | Alternate screen memory location. |
| `SCREEN_CHAR_LOC4` | $C400 | Alternate screen memory location. |
| `SCREEN_COL_LOC` | $D800 | Color RAM. |
| `SCREEN_CTRL` | $D011 | VIC-II control register 1 (bitmap mode, display enable, Y-scroll, raster-compare high bit). |
| `RASTERLINE_POS` | $D012 | Raster line compare/read register. |
| `BANK_SIZE` | $4000 | Size of one VIC-II bank (16 KB), not a register address. |
| `VIC_BANK0` | 3 (byte) | Bank-select value for `$0000`-`$3FFF`. |
| `VIC_BANK1` | 2 (byte) | Bank-select value for `$4000`-`$7FFF`. |
| `VIC_BANK2` | 1 (byte) | Bank-select value for `$8000`-`$BFFF`. |
| `VIC_BANK3` | 0 (byte) | Bank-select value for `$C000`-`$FFFF`. |
| `VIC_DATA_LOC` | $D018 | VIC-II memory control register (screen/charset base within the current bank). |
| `MULTICOLOR_CHAR_COL` | $D021 | Same address as `SCREEN_FG_COL`; used as the shared multicolor-mode background color. |
| `SCREEN_WIDTH` | 40 (byte) | Text-mode screen width in characters. |
| `SCREEN_HEIGHT` | 25 (byte) | Text-mode screen height in characters. |

Several builtins that take a screen or hardware address only accept a
named `address` constant or a `^`-prefixed literal, not a bare numeric
literal; see the Known limitations sections on
[`Call`](builtins/call.md), [`ClearBitmap`](builtins/clearbitmap.md),
[`CopyCharsetFromRom`](builtins/copycharsetfromrom.md),
[`CopyFullScreen`](builtins/copyfullscreen.md),
[`CopyHalfScreen`](builtins/copyhalfscreen.md), [`Poke`](builtins/poke.md),
and [`TransformColors`](builtins/transformcolors.md). These constants are
the working form for that case.

## Sprite registers

All `address`-typed.

| Name | Value | Notes |
| --- | --- | --- |
| `SPRITE_POS` | $D000 | First of 8 X/Y position register pairs. |
| `SPRITE_COLOR` | $D027 | First of 8 per-sprite color registers. |
| `SPRITE_DATA` | $0340 | Default sprite data (shape) area. |
| `SPRITE_DATA_LOC` | $07F8 | Sprite pointer table (which 64-byte block each sprite reads its shape from). |
| `SPRITE_BITMASK` | $D015 | Sprite-enable register (one bit per sprite). |
| `SPRITE_MULTICOLOR` | $D01C | Per-sprite multicolor-mode enable register. |
| `SPRITE_MULTICOLOR_REG1` | $D025 | Shared multicolor 1 register. |
| `SPRITE_MULTICOLOR_REG2` | $D026 | Shared multicolor 2 register. |
| `SPRITE_STRETCH_X` | $D01D | Sprite X-expand register. |
| `SPRITE_STRETCH_Y` | $D017 | Sprite Y-expand register. |
| `SPRITE_COLLISION` | $D01E | Sprite-to-sprite collision register. |
| `SPRITE_BG_COLLISION` | $D01F | Sprite-to-background collision register. |

[`SetSpriteLoc`](builtins/setspriteloc.md) hardcodes the address
`SPRITE_DATA_LOC` points to rather than reading it back, see that page's
Known limitations section.

## Sound (SID)

| Name | Value | Type | Notes |
| --- | --- | --- | --- |
| `SID` | $D400 | address | Base address of the SID chip. |
| `SID_CHANNEL1` | 0 | byte | Voice 1 register offset. |
| `SID_CHANNEL2` | 7 | byte | Voice 2 register offset. |
| `SID_CHANNEL3` | 14 | byte | Voice 3 register offset. |
| `SID_TRI` | 16 | byte | Triangle waveform bit, for [`PlaySound`](builtins/playsound.md)'s waveform parameters. |
| `SID_SAW` | 32 | byte | Sawtooth waveform bit. |
| `SID_PULSE` | 64 | byte | Pulse (square) waveform bit. |
| `SID_NOISE` | 128 | byte | Noise waveform bit. |

See `PlaySound`'s Known limitations section: its two waveform parameters
write the same register back to back, so only the second one actually
takes effect.

## 6502 registers

Named pseudo-variables for the 6502's own registers, usable directly in
ordinary statements (`_A := 13;`) as well as inside
[`asm`](keywords/asm.md)/[`assembler`](keywords/assembler.md) blocks; the
compiler recognizes these names specially rather than treating them as
regular variables.

| Name | Value | Notes |
| --- | --- | --- |
| `_A` | 0 | Accumulator. |
| `_X` | 0 | X index register. |
| `_Y` | 0 | Y index register. |
| `_AX` | 0 | Combined A/X (used by builtins that return a 16-bit value across both registers). |
| `_AY` | 0 | Combined A/Y. |
| `_XY` | 0 | Combined X/Y. |

## Example

```pascal
program ConstantsDemo;

begin
	clearscreen(key_space,screen_char_loc);

	// Colors: BLUE/LIGHT_BLUE are plain byte constants
	screen_bg_col := blue;
	screen_fg_col := light_blue;

	// Screen/VIC-II registers: screen_char_loc is an address constant
	moveto(0,0,hi(screen_char_loc));
	printstring("CONSTANTS DEMO",0,40);

	// Sprite registers: SPRITE_BITMASK is an address constant, Poke
	// writes through it directly (turns all 8 sprites off)
	Poke(SPRITE_BITMASK,0,0);

	// Keyboard: KEY_A is a byte scan code, printed here as a number
	moveto(0,2,hi(screen_char_loc));
	printstring("KEY_A CODE:",0,40);
	moveto(12,2,hi(screen_char_loc));
	printdecimal(KEY_A,3);

	// Joystick: JOY_FIRE is a bitmask, printed here as a number
	moveto(0,3,hi(screen_char_loc));
	printstring("JOY_FIRE MASK:",0,40);
	moveto(15,3,hi(screen_char_loc));
	printdecimal(JOY_FIRE,3);

	// Sound (SID): SID_TRI is a waveform bit, printed here as a number
	moveto(0,4,hi(screen_char_loc));
	printstring("SID_TRI VALUE:",0,40);
	moveto(15,4,hi(screen_char_loc));
	printdecimal(SID_TRI,3);

	// 6502 registers: _A loads the accumulator directly, used here to
	// call the KERNAL CHROUT routine and print a carriage return
	_A := 13;
	call(^$FFD2);

	loop();
end.
```

[:material-download: Download this example](../assets/examples/constants.ras){ .md-button download }

## Known limitations

`Joy1`, `Joy2`, `Joy1Pressed`, and `Joy2Pressed` are listed among this
fork's reserved constant names, but none of the four actually work: each
is missing its type and value, so no usable constant is ever created for
any of them, under any casing. Referencing any of the four in code fails
to compile with "Could not find variable", as if the name had never been
declared at all. This is a pre-existing gap in the underlying constant
list, not something specific to any one program. Use
[`Joystick`](builtins/joystick.md) or `ReadJoy1`/`ReadJoy2` with the
`JOY_*` bitmasks in the Joystick table above instead; both are fully
working.
