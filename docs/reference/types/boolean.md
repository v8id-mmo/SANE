# `boolean`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A true/false value. Used for flags, loop/`if` conditions, and the result
of a comparison or logical expression ([`and`](../operators/and.md),
[`or`](../operators/or.md), [`not`](../operators/not.md)).

## Syntax

    var
        <name> : boolean;
        <name> : boolean = true;   // or false

## Parameters

- `<name>`: the variable's identifier.
- `true`/`false`: the two literal values a `boolean` can hold.

## Example

```pascal
program BooleanDemo;
var
	gameOver : boolean = false;
	lives : byte = 3;
	flags : array[3] of boolean;
begin
	clearscreen(key_space,screen_char_loc);

	flags[0] := true;
	flags[1] := false;
	flags[2] := not flags[1];

	lives := lives - 3;
	if (lives = 0) then
		gameOver := true;

	moveto(0,0,hi(screen_char_loc));
	if (gameOver) then
		printstring("game over: yes",0,40)
	else
		printstring("game over: no",0,40);

	moveto(0,1,hi(screen_char_loc));
	if (flags[0] and flags[2]) then
		printstring("flags 0+2: both set",0,40)
	else
		printstring("flags 0+2: not both set",0,40);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/boolean.ras){ .md-button download }
