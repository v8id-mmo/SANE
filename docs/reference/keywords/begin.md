# `begin`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Marks the start of a block of statements, in classic Pascal style. A
`begin` is always closed by a matching `end` (or, for the program's own
top-level block, `end.` with a trailing period).

## Syntax

    begin
      <statements>
    end;

## Where it's used

- The program's top-level statement block (closed with `end.`).
- A procedure or function body.
- The body of `if`/`while`/`for`/`fori` when it spans more than one
  statement.

## Example

```pascal
program BeginDemo;
var
	i : byte = 0;

procedure Blink();
begin
	screen_bg_col := i;
end;

begin
	for i := 0 to 10 do
	begin
		Blink();
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/begin.ras){ .md-button download }
