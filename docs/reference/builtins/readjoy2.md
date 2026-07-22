# `ReadJoy2`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads joystick port 2 and decodes it into three compiler-declared byte
variables: `joy2`, `joy2last`, and `joy2pressed`, the same shape as
[`ReadJoy1`](readjoy1.md)'s `joy1`/`joy1last`/`joy1pressed` but for the
second port.

The first time `readjoy2(` appears in the source, the compiler
automatically includes [`initJoy2`](initjoy2.md), which declares
`joy2`/`joy2last`/`joy2pressed` and the shared decoding routine.

## Syntax

    ReadJoy2()

## Example

```pascal
program ReadJoy2Demo;
var
	state : byte;
begin
	clearscreen(key_space,screen_char_loc);
	readjoy2(); // fills in joy2/joy2last/joy2pressed
	state := joy2; // raw bitmask; test with JOY_UP/JOY_DOWN/JOY_LEFT/JOY_RIGHT/JOY_FIRE

	moveto(0,0,hi(screen_char_loc));
	printstring("joy2:",0,40);
	moveto(6,0,hi(screen_char_loc));
	printdecimal(state,3);

	if (joy2 & JOY_FIRE = JOY_FIRE) then
		screen_bg_col := red;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/readjoy2.ras){ .md-button download }
