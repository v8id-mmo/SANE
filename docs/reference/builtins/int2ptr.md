# `int2ptr`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reinterprets an `integer` value as a `pointer`, so the result of ordinary
integer arithmetic (a base address plus an offset, for example) can be
assigned to a pointer variable and dereferenced. `integer` and `pointer`
are both stored as the same 16-bit little-endian value on this target, so
`int2ptr` doesn't change any bits: it exists purely to satisfy the type
checker, which otherwise refuses to assign an `integer` expression
straight into a `pointer` variable.

## Syntax

    <pointer> := int2ptr( <integer expression> )

## Parameters

- `<integer expression>`: any `integer`-typed value or expression, pure
  or complex.

## Returns

The same 16-bit value, typed as a `pointer`.

## Example

```pascal
program Int2PtrDemo;
var
	base : integer = $c000;
	p : ^byte;
	value : byte;
begin
	clearscreen(key_space,screen_char_loc);
	// base+5 is computed as plain integer arithmetic, then reinterpreted
	// as a pointer so it can be dereferenced
	p := int2ptr(base+5);
	p[0] := 42;
	value := p[0];
	moveto(0,0,hi(screen_char_loc));
	printdecimal(value,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/int2ptr.ras){ .md-button download }
