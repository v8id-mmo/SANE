# `Abs`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
gets `Abs` wrong on a `long` value, and on an `integer` value whose low
byte is `$00`; SANE fixes both.

Returns the absolute (unsigned magnitude) value of a signed number. A
negative input becomes positive; a positive input is unchanged.

## Syntax

    <byte or integer> = Abs( <byte or integer> )

## Parameters

- `<value>`: a `byte` or `integer` value, treated as signed (bit 7 of the
  highest byte is the sign bit) regardless of whether it was actually
  declared `signed`.

## Returns

The absolute value, same width as the input.

## Example

```pascal
program AbsDemo;
var
	b : signed byte = -100;
	w : signed integer = -30000;
	resultByte : byte;
	resultWord : integer;

begin
	clearscreen(key_space,screen_char_loc);
	resultByte := abs(b);
	resultWord := abs(w);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(resultByte,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(resultWord,5);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/abs.ras){ .md-button download }

## Known limitations

`Abs` is correct for `byte` values: it checks bit 7 of the value and
two's-complements it if set.

**In vanilla TRSE, the `integer` path is subtly wrong: it negates the high
and low bytes independently and never propagates the low byte's own
carry-out into the high byte, so `Abs` of a negative value whose low byte
is `$00` (e.g. -256, -512, ...) gives the wrong result** (`abs(-256)`
returns `0` instead of `256`); values whose low byte is nonzero are
unaffected.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the `integer` path now checks the low byte's carry-out and propagates it
into the high byte.

**In vanilla TRSE, `Abs` is also wrong for a `long` value.** Instead of
using a real 24-bit negation, it silently falls back to the plain `byte`
path: it checks bit 7 of only the *low* byte (the wrong byte for a 24-bit
value's sign) and, if that happens to be set, negates only that one byte,
leaving the middle and high bytes completely unchanged.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`Abs` now has a dedicated `long` path that checks the correct (top) byte's
sign and negates all three bytes together with real carry propagation
between them.
