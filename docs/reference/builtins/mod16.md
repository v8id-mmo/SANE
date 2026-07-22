# `mod16`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

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

`mod16` shares its underlying division routine directly with
[`/`](../operators/division.md)'s 16-bit-by-8-bit division, so it
inherits that same limitation: the routine is unsigned only, with no
`signed`-aware code path at all. A negative `signed integer` dividend or
`signed byte` divisor is computed against its unsigned bit pattern, not
its signed value, giving a wrong remainder. See [`mod`](mod.md) for the
same limitation on the 8-bit builtin.
