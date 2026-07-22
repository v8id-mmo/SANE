# `Sqrt`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Computes the integer square root of a 16-bit value. Auto-init: the first
time `sqrt(` appears in a file, the compiler automatically includes the
routine this builtin needs.

## Syntax

    Sqrt(value : integer) : byte

## Parameters

- `value`: the `integer` (16-bit) value to take the square root of.

## Returns

The floored integer square root, as a `byte` (`0`-`255`, since
`sqrt(65535)` floors to `255`). There's no fractional/real-number result;
this is a pure integer routine, correct across the full 16-bit input
range.

## Example

```pascal
program SqrtDemo;
var
	value : integer;
	result : byte;
begin
	clearscreen(key_space, screen_char_loc);
	value := 200;
	result := Sqrt(value);
	moveto(0,0,hi(screen_char_loc));
	printstring("sqrt(200)=",0,40);
	moveto(10,0,hi(screen_char_loc));
	printdecimal(result,2); // 3 digits: prints "014"
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/sqrt.ras){ .md-button download }

## Known limitations

`Sqrt` needs 4 of the project's internal zero-page scratch slots
(configured via the `zeropage_internal1`-`4` project settings) to hold
its working state. The shipped default project settings always provide
all 4, so this doesn't affect a normal project, but if a project's
settings provide fewer than 4, `Sqrt` silently compiles to no code at
all, with no compiler error.
