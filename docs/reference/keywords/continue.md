# `continue`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Skips the rest of the current loop iteration and jumps straight to the
next one, in the innermost enclosing loop. In a `for`/`fori` loop this
still runs the loop's own step/increment before re-testing the loop
condition, the same way `continue` behaves in most other languages
(confirmed in `abstractcodegen.cpp`: the label `continue` jumps to sits
right before the increment-and-compare step, not before it).

## Syntax

    continue;

## Example

```pascal
program ContinueDemo;
var
	i : byte = 0;

begin
	for i := 0 to 20 do
	begin
		if (i&1=1) then continue; // skip odd numbers
		screen_bg_col := i;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/continue.ras){ .md-button download }
