# `Random`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns a raw random byte in the full `0`-`255` range, seeded from a
hardware timer. Unlike [`Rand`](rand.md), it takes no range parameters
and is used directly as an expression, not by passing an output
variable.

The first time `random(` appears in the source, the compiler
automatically includes the setup routine this builtin needs.

## Syntax

    Random()

## Returns

A `byte` in the range `0`-`255`.

## Example

```pascal
program RandomDemo;
var
	r : byte;
begin
	clearscreen(key_space,screen_char_loc);
	r := random(); // raw byte in [0,255], no range parameters
	moveto(0,0,hi(screen_char_loc));
	printstring("random:",0,40);
	moveto(8,0,hi(screen_char_loc));
	printdecimal(r,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/random.ras){ .md-button download }
