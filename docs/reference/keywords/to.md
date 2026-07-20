# `to`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Separates a [`for`](for.md) loop's start value from its end value. Used
nowhere else in the language.

## Syntax

    for <var> := <start> to <end> do
        <statement>;

## Example

```pascal
program ToDemo;

var
	i : byte;
	total : byte = 0;

begin
	for i:=0 to 10 do
		total := total + i;
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/to.ras){ .md-button download }

## Known limitations

The value after `to` is only checked for equality against the loop
counter, not compared as an upper bound. See [`for`](for.md)'s Known
limitations for what this means in practice (the loop body always runs at
least once, and the counter can wrap all the way around if the end value
is already behind the start value).
