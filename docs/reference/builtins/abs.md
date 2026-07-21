# `Abs`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

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

`Abs` is correct for `byte` and `integer` values: the `byte` path checks
bit 7 of the value and two's-complements it if set; the `integer` path
checks bit 7 of the high byte and two's-complements both bytes together.

It is **wrong for a `long` value**. Instead of using a real 24-bit
negation, it silently falls back to the plain `byte` path: it checks bit 7
of only the *low* byte (the wrong byte for a 24-bit value's sign) and, if
that happens to be set, negates only that one byte, leaving the middle and
high bytes completely unchanged. There is currently no way to get a
correct 24-bit absolute value through this builtin; compute it by hand
(compare the high byte's bit 7, then negate all three bytes with a
carry-propagating two's complement) if you need this on a `long`.
