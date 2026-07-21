# `if`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The standard conditional statement: runs one branch of code if a condition
is true, and optionally a different branch (via [`else`](else.md)) if it's
false.

## Syntax

If with 1 command:

    if <condition> then
        <statement>;

If with 1 commands in each branch:

    if <condition> then
        <statement>
    else
        <statement>;

If with multiple commands in each branch:

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
	score : byte = 10;  // change this and rerun

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

There's also a compile-time [`@if`](../directives/if.md) preprocessor
directive (distinct from this statement, evaluated before compilation
even starts), which checks a value previously set with
[`@define`](../directives/define.md) and is closed with
[`@endif`](../directives/endif.md), the same way
[`@ifdef`](../directives/ifdef.md) is.
