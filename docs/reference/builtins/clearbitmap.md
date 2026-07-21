# `ClearBitmap`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Clears a run of bitmap (hi-res graphics) memory to zero, one or more
256-byte pages at a time.

## Syntax

    ClearBitmap( <address>, <page count> );

## Parameters

- `<address>`: the start address of the bitmap area to clear. Must be a
  compile-time constant (see Known limitations).
- `<page count>`: how many 256-byte pages to clear (e.g. `32` clears the
  standard 8192-byte C64 hi-res bitmap). Must also be a compile-time
  constant.

## Example

```pascal
program ClearBitmapDemo;
var
	const bitmapAddr : address = $2000;
begin
	clearbitmap(bitmapAddr, 32); // clear 32 pages (8192 bytes) of bitmap memory to 0

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/clearbitmap.ras){ .md-button download }

## Known limitations

Both parameters must be known at compile time; passing a `pointer` or
other variable for the address is rejected with a clear "both parameters
must be integer constants" compiler error, not silently accepted.

**A bare numeric literal address (`clearbitmap($2000, 32)`) fails to
assemble.** The generated code is `sta #$2000,y` for every page, an
invalid instruction (`sta` has no immediate addressing mode), and the
build fails at the assembly stage with an "opcode type not implemented"
error. Always route the address through a named `address` constant
instead (as in the example above), which emits the correct `sta
$2000,y` form.

Clearing always writes zero; there is no variant that fills with an
arbitrary byte value the way [`ClearScreen`](clearscreen.md) does.
