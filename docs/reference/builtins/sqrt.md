# `Sqrt`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
fails with a confusing, unrelated assembler error if the project is
missing its internal zero-page scratch settings; SANE raises a clear
compile error naming the actual missing settings instead.

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
all 4, so this doesn't affect a normal project.

**In vanilla TRSE, if a project's settings are missing one or more of
`zeropage_internal1`-`4`, `Sqrt` fails at the assembly stage with a
confusing, unrelated error** ("Opcode type not implemented or illegal:
sty type 0") instead of a clear diagnostic naming the actual problem.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a missing `zeropage_internal1`-`4` setting now raises a clear compile
error ("Sqrt requires zeropage_internal1-4 to be configured in the
project settings.") instead of the confusing assembler-stage failure.
