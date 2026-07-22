# `initJoy1`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the joystick port 1 reading routine used by `ReadJoy1`, and
declares the `joy1`/`joy1last`/`joy1pressed` state bytes it populates.
Normally included automatically the first time `readjoy1(` appears in the
source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initjoy1();

## Example

```pascal
program InitJoy1Demo;

// readjoy1() normally auto-includes initJoy1 the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// port-1 reading routine into the build.
@ignoremethod initjoy1

begin
	initjoy1();

	readjoy1();

	screen_bg_col := joy1;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initjoy1.ras){ .md-button download }
