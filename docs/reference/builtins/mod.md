# `mod`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
computed the remainder using unsigned arithmetic regardless of a
`signed byte` operand; SANE makes it sign-aware.

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

**In vanilla TRSE, `mod` computes its remainder using a plain unsigned
repeated-subtraction loop, with no awareness of `signed byte` at all**:
it inherits the same unsigned-only limitation as [`/`](../operators/division.md)'s
signed division gap, just for the remainder instead of the quotient. A
negative `signed byte` operand gives a result computed against its
unsigned bit pattern, not its signed one.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`mod`'s remainder now follows C-style truncating semantics, with its sign
matching the dividend `<a>`'s sign regardless of the divisor's sign. For
16-bit values, see [`mod16`](mod16.md), which shared this same
limitation for a related reason.
