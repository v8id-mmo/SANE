# `do`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Separates a loop's header (the `for`/`fori`/`while` condition) from its
body, in classic Pascal style.

## Syntax

    for <var> := <from> to <to> do <statement or block>
    while (<condition>) do <statement or block>

## Example

```pascal
program DoDemo;
var
	i : byte = 0;

begin
	for i := 0 to 10 do
	begin
		screen_bg_col := i;
	end;

	while (i > 0) do
	begin
		i := i - 1;
	end;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/do.ras){ .md-button download }
