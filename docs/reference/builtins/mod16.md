# `mod16`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
computed the remainder using unsigned arithmetic regardless of either
operand's sign; SANE makes it sign-aware.

Returns the remainder of dividing an `integer` (16-bit) value by a `byte`
value. Auto-init: the first time `mod16(` appears in a file, the compiler
automatically includes the 16-bit-by-8-bit division routine it needs.

## Syntax

    <integer> = mod16( <a>, <b> )

## Parameters

- `<a>`: the dividend, an `integer` value.
- `<b>`: the divisor, a `byte` value.

## Returns

`<a>` mod `<b>` (the remainder of `<a> / <b>`).

## Example

```pascal
program Mod16Demo;
var
	a : integer = 1000;
	b : byte = 7;
	result : integer;

begin
	clearscreen(key_space,screen_char_loc);
	result := mod16(a,b);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,5); // 1000 mod 7 = 6

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/mod16.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, `mod16` shares its underlying division routine
directly with [`/`](../operators/division.md)'s 16-bit-by-8-bit
division, so it inherits that same limitation: the routine is unsigned
only, with no `signed`-aware code path at all.** A negative `signed
integer` dividend or `signed byte` divisor is computed against its
unsigned bit pattern, not its signed value, giving a wrong remainder. See
[`mod`](mod.md) for the same limitation on the 8-bit builtin.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`mod16`'s remainder now follows C-style truncating semantics, with its
sign matching the dividend `<a>`'s own sign regardless of the divisor's
sign.

**If `<a>` is passed as a `signed byte` value that still needs widening to
a word as part of the call** (rather than already being declared a
`signed integer`), it's zero-extended instead of sign-extended, giving a
wrong result. A dividend that's already declared `signed integer` is
unaffected. Still open.
