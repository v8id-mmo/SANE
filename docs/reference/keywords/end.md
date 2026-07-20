# `end`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Closes a block opened by [`begin`](begin.md), or a [`case`](case.md)
statement. The program's own top-level block is closed with `end.` (a
trailing period), marking the end of the whole file; every other `end`
is followed by a semicolon.

## Syntax

    begin
      <statements>
    end;

    // only for the program's own top-level block:
    begin
      <statements>
    end.

## Example

```pascal
program EndDemo;
var
	i : byte = 0;

procedure SetColor();
begin
	screen_bg_col := i;
end;

begin
	for i := 0 to 5 do
	begin
		SetColor();
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/end.ras){ .md-button download }
