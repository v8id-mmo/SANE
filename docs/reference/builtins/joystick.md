# `Joystick`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads the given joystick port and decodes it into five separate
compiler-declared byte variables: `joystickup`, `joystickdown`,
`joystickleft`, `joystickright`, and `joystickbutton`, each set to `1` if
that direction/button is currently active, `0` otherwise. Call it once
per frame (or whenever a fresh reading is needed), then read those five
variables directly in your own code; they aren't passed back as a return
value.

The first time `joystick(` appears in the source, the compiler
automatically includes [`initjoystick`](initjoystick.md), which declares
those five variables and the shared decoding routine.

## Syntax

    Joystick( <port> )

## Parameters

- `<port>`: a compile-time constant, `1` or `2`, selecting which CIA
  joystick port to read. Any other value is a compile-time error.

## Example

```pascal
program JoystickDemo;
var
	upVal, downVal, leftVal, rightVal, buttonVal : byte;
begin
	clearscreen(key_space,screen_char_loc);
	// Polls port 2 and fills in the joystickup/down/left/right/button
	// globals the compiler auto-declares the first time joystick( is used
	joystick(2);
	upVal := joystickup;
	downVal := joystickdown;
	leftVal := joystickleft;
	rightVal := joystickright;
	buttonVal := joystickbutton;

	moveto(0,0,hi(screen_char_loc));
	printdecimal(upVal,3);
	moveto(0,1,hi(screen_char_loc));
	printdecimal(downVal,3);
	moveto(0,2,hi(screen_char_loc));
	printdecimal(leftVal,3);
	moveto(0,3,hi(screen_char_loc));
	printdecimal(rightVal,3);
	moveto(0,4,hi(screen_char_loc));
	printdecimal(buttonVal,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/joystick.ras){ .md-button download }
