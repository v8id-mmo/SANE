# `while`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A pre-condition loop: the condition is checked before each pass through
the body, so the body may run zero times if the condition is already
false. The counterpart to [`repeat`](repeat.md)/[`until`](until.md), which
always runs the body at least once.

## Syntax

    while (<condition>) do
        <statement>;

    while (<condition>) do
    begin
        <statements>;
    end;

`onpage`/`offpage` can be applied the same way as on [`if`](if.md).

## Parameters

- `<condition>`: checked before each pass through the body. The loop keeps
  running while this is true, and exits the moment it's false.

## Example

```pascal
program WhileDemo;
var
	i : byte = 0;

begin
	while (i < 10) do
	begin
		screen_bg_col := i;
		i := i + 1;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/while.ras){ .md-button download }
