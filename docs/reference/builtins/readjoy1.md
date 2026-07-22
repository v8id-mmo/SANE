# `ReadJoy1`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads joystick port 1 and decodes it into three compiler-declared byte
variables: `joy1` (a live bitmask, one bit per direction/button, test
with the `JOY_UP`/`JOY_DOWN`/`JOY_LEFT`/`JOY_RIGHT`/`JOY_FIRE`
constants), `joy1last` (the previous reading), and `joy1pressed` (bits
that just transitioned from released to held this call). This is the
lower-level, bitmask-based counterpart to [`Joystick`](joystick.md),
which decodes into five separate `0`/`1` variables instead.

The first time `readjoy1(` appears in the source, the compiler
automatically includes [`initJoy1`](initjoy1.md), which declares
`joy1`/`joy1last`/`joy1pressed` and the shared decoding routine.

## Syntax

    ReadJoy1()

## Example

```pascal
program ReadJoy1Demo;
var
	state : byte;
begin
	clearscreen(key_space,screen_char_loc);
	readjoy1(); // fills in joy1/joy1last/joy1pressed
	state := joy1; // raw bitmask; test with JOY_UP/JOY_DOWN/JOY_LEFT/JOY_RIGHT/JOY_FIRE

	moveto(0,0,hi(screen_char_loc));
	printstring("joy1:",0,40);
	moveto(6,0,hi(screen_char_loc));
	printdecimal(state,3);

	if (joy1 & JOY_FIRE = JOY_FIRE) then
		screen_bg_col := red;

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/readjoy1.ras){ .md-button download }
