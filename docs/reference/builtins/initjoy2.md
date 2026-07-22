# `initJoy2`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the joystick port 2 reading routine used by `ReadJoy2`, and
declares the `joy2`/`joy2last`/`joy2pressed` state bytes it populates.
Normally included automatically the first time `readjoy2(` appears in the
source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initjoy2();

## Example

```pascal
program InitJoy2Demo;

// readjoy2() normally auto-includes initJoy2 the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// port-2 reading routine into the build.
@ignoremethod initjoy2

begin
	initjoy2();

	readjoy2();

	screen_bg_col := joy2;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initjoy2.ras){ .md-button download }
