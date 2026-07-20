# `if`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The standard conditional statement: runs one branch of code if a condition
is true, and optionally a different branch (via [`else`](else.md)) if it's
false.

## Syntax

    if <condition> then
        <statement>;

    if <condition> then
        <statement>
    else
        <statement>;

    if <condition> then
    begin
        <statements>;
    end
    else
    begin
        <statements>;
    end;

## Parameters

- `<condition>`: any boolean expression (comparison, `and`/`or`/`not`
  combination, or a boolean variable).

## Example

```pascal
program IfDemo;

var
	score : byte = 10;

begin
	if score > 5 then
		screen_bg_col := white
	else
		screen_bg_col := black;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/if.ras){ .md-button download }

## See also

There's also a compile-time `@if <name> = <value>` preprocessor directive
(distinct from this statement, evaluated before compilation even starts),
which checks a value previously set with [`@define`](define.md) and is
closed with [`@endif`](endif.md), the same way [`@ifdef`](ifdef.md) is.
