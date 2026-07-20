# `break`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Immediately exits the innermost enclosing loop, skipping any remaining
iterations.

## Syntax

    break;

## Example

```pascal
program BreakDemo;
var
	i : byte = 0;

begin
	for i := 0 to 100 do
	begin
		if (i = 50) then break; // leave this loop when i reaches 50
		screen_bg_col := i;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/break.ras){ .md-button download }
