# `max`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns the larger of two `byte` values.

## Syntax

    <byte> = max( <a>, <b> )

## Parameters

- `<a>`: a `byte` variable, constant, or expression.
- `<b>`: a `byte` variable or constant (must be a plain variable/constant,
  not a more complex expression).

## Returns

Whichever of `<a>`/`<b>` is larger.

## Example

```pascal
program MaxDemo;
var
	a : byte = 17;
	b : byte = 5;
	result : byte;

begin
	clearscreen(key_space,screen_char_loc);
	result := max(a,b);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/max.ras){ .md-button download }

## Known limitations

`max` compares its two `byte` operands as plain unsigned values, with no
awareness of `signed byte` at all. For a pair straddling the sign
boundary, this gives the wrong answer: `max(-1, 1)` returns `-1`, not `1`,
because `-1`'s bit pattern (`$FF`) is unsigned-larger than `1`. If either
operand can be negative, compare and branch manually instead of relying on
`max`. See [`min`](min.md) for the same issue on the other side.
