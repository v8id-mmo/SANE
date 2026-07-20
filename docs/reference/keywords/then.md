# `then`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Separates an [`if`](if.md) statement's condition from the branch of code
that runs when the condition is true.

## Syntax

    if <condition> then
        <statement>;

    if <condition> then
        <statement>
    else
        <statement>;

## Example

```pascal
program ThenDemo;

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

[:material-download: Download this example](../../assets/examples/then.ras){ .md-button download }

## Known limitations

`if` and `while` are parsed by the same shared code, and that
code doesn't actually check which of the two it's parsing before
accepting the separator keyword. In practice this means `then` is also
silently accepted after a `while` condition (in place of the idiomatic
`do`), and `do` is silently accepted after an `if` condition (in place of
the idiomatic `then`). Neither is standard style and neither should be
relied on, but both compile without error.
