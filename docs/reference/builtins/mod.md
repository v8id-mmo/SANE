# `mod`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns the remainder of dividing one `byte` value by another.

## Syntax

    <byte> = mod( <a>, <b> )

## Parameters

- `<a>`: the dividend, a `byte` value.
- `<b>`: the divisor, a `byte` value.

## Returns

`<a>` mod `<b>` (the remainder of `<a> / <b>`).

## Example

```pascal
program ModDemo;
var
	a : byte = 17;
	b : byte = 5;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := mod(a,b);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,3); // 17 mod 5 = 2

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/mod.ras){ .md-button download }

## Known limitations

`mod` computes its remainder using a plain unsigned repeated-subtraction
loop, with no awareness of `signed byte` at all: it inherits the same
unsigned-only limitation as [`/`](../operators/division.md)'s signed
division gap, just for the remainder instead of the quotient. Passing a
negative `signed byte` operand gives a result computed against that
value's unsigned bit pattern, not its signed one. For 16-bit values, see
[`mod16`](mod16.md), which shares this same limitation for a related
reason.
