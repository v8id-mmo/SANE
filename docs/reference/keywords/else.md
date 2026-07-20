# `else`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The optional branch of an `if`/`then` statement that runs when the
condition is false. Also usable inside [`case`](case.md), as its optional
default branch.

## Syntax

    if (<condition>) then <statement>
    else <statement>;

As in standard Pascal, there must be **no semicolon** directly before
`else`; a semicolon ends the whole `if` statement, so `else` would no
longer be attached to it.

## Example

```pascal
program ElseDemo;
var
	i : byte = 0;

begin
	if (i = 0) then
		screen_bg_col := black
	else
		screen_bg_col := white;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/else.ras){ .md-button download }
