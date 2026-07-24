# Loading a file from disk with the KERNAL

Any asset too big to keep as inline data (a charset, sprite sheet, music
player, or level) is more practical to load from disk at runtime than to
bake into the `.prg` itself. This recipe wraps the three KERNAL calls a
C64 program needs to load a named file from a disk drive into a chosen
memory address: `SETLFS`, `SETNAM`, and `LOAD`.

## What this uses

- [`Call`](../reference/builtins/call.md) - jumps to a fixed KERNAL
  routine address and returns once it hits `rts`.
- [`_A`/`_X`/`_Y`](../reference/constants.md#6502-registers) - the 6502
  registers each KERNAL routine reads its parameters from.
- [`lo`](../reference/builtins/lo.md)/[`hi`](../reference/builtins/hi.md) -
  split a 16-bit address into the low/high bytes `_X`/`_Y` expect.
- The address-of operator (`#`) - gets a string variable's own address to
  pass to `SETNAM`.

```pascal
program KernalFileLoad;

// Named address constants for the three KERNAL routines this needs.
// Call() doesn't accept a bare numeric literal address directly, so
// these have to be declared first.
var
	const SETLFS : address = $ffba; // set logical file number, device, secondary address
	const SETNAM : address = $ffbd; // set filename
	const LOAD   : address = $ffd5; // load (or verify) a file from the open device

	fileName       : string = "DATA";
	fileNameLength : byte = 4;
	loadAddress    : integer = $3000;

procedure loadFile();
begin
	_A := 1; _X := 8; _Y := 0;        // logical file 1, device 8 (disk), sec. addr 0
	Call(SETLFS);

	_A := fileNameLength;
	_X := lo(#fileName); _Y := hi(#fileName);
	Call(SETNAM);

	_A := 0;                           // 0 = load, not verify
	_X := lo(loadAddress); _Y := hi(loadAddress);
	Call(LOAD);                        // secondary address 0 above means:
	                                    // ignore the file's own 2-byte header,
	                                    // load to loadAddress instead
end;

begin
	clearscreen(key_space,screen_char_loc);

	loadFile();

	moveto(1,1,hi(screen_char_loc));
	printstring("file loaded from disk",0,22);
	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/kernal-file-load.ras){ .md-button download }

## How it works

Loading a file through the KERNAL is always this same three-call
sequence. `SETLFS` (`$ffba`) tells the KERNAL which logical file number
to use, which device to read from (`8` is the first disk drive), and the
secondary address: `0` here means "ignore whatever 2-byte load address is
stored in the file itself, and load to the address I give you instead",
which is what makes `loadAddress` below actually take effect. `SETNAM`
(`$ffbd`) hands over the filename as a length plus a pointer,
`fileNameLength` and `#fileName` (the address of the string variable,
not its contents), since PETSCII filenames on disk aren't stored with the
same zero-terminator SANE's own `string` type uses. `LOAD` (`$ffd5`)
does the actual work: `_A := 0` selects load mode over verify mode, and
`_X`/`_Y` (via `lo`/`hi`) give it the 16-bit destination address to load
into, split into its low and high byte since each 6502 register only
holds one byte. Every KERNAL call goes through
[`Call`](../reference/builtins/call.md), and needs a named `address`
constant rather than a bare `$ffba`-style literal (see that page's own
known limitation) which is why `SETLFS`/`SETNAM`/`LOAD` are declared as
constants up front instead of written inline. This same pattern (only the
filename and destination address change) is how a real project loads a
charset, a sprite sheet, or a music player packed as a separate file on
the same disk as the `.prg`, rather than baking every asset into one
large program.
