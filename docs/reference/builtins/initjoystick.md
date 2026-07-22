# `initjoystick`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the generic joystick-reading routine used by
[`Joystick`](joystick.md), and
declares the direction/button state bytes it populates. Normally included
automatically the first time `joystick(` appears in the source; calling
it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initjoystick();

## Example

```pascal
program InitJoystickDemo;

// joystick( normally auto-includes initjoystick the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// generic joystick-reading routine into the build.
@ignoremethod initjoystick

var
	dir : byte;

begin
	initjoystick();

	dir := joystick(2);

	screen_bg_col := dir;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initjoystick.ras){ .md-button download }
