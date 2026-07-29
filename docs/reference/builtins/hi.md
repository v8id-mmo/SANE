# `Hi`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
silently generates no code at all for `Hi`/`Lo` on a `long` value; SANE
adds a `long`-aware case so it works there too.

Returns the high byte (bits 8-15) of a 16-bit value. [`Lo`](lo.md) is the
counterpart for the low byte, and `bankbyte` reads the third byte of a
wider, 24-bit-addressable value.

## Syntax

    <byte> = hi( <variable> )

## Parameters

- `<variable>`: a `pointer`, `address`, or `integer` value. On a plain
  `byte` value, the high byte is always `0`.

## Returns

The high byte of the value.

## Example

```pascal
program HiLoDemo;
var
	ptr : ^byte;
	w : integer = $1234;
	b : byte;
begin
	clearscreen(key_space,screen_char_loc);
	ptr := $c000;

	b := lo(ptr);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(b,3);

	b := hi(ptr);
	moveto(0,1,hi(screen_char_loc));
	printdecimal(b,3);

	b := lo(w);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(b,3);

	b := hi(w);
	moveto(0,3,hi(screen_char_loc));
	printdecimal(b,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/hi.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, `Hi` (and [`Lo`](lo.md)) work correctly on `pointer`,
`address`, and `integer` values, as in the example above. On a `long`
variable, this fork's other 24-bit type, both are a silent no-op: no code
at all is generated for the call, so the destination variable ends up
holding whatever was already in the accumulator at that point in the
program, not any byte of the `long` value. This is the same underlying
gap as `bankbyte`'s known limitation on `long`.**

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`Hi`/`Lo`/`bankbyte` now correctly return the requested byte of a `long`
value too, the same as they already did for `pointer`/`integer`.
