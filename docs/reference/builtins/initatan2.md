# `initatan2`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the angle lookup table and calculation routine used by `Atan2`.
Normally included automatically the first time `atan2(` appears in the
source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initatan2();

## Example

```pascal
program InitAtan2Demo;

// atan2( normally auto-includes initatan2 the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// angle table and routine into the build.
@ignoremethod initatan2

var
	angle : byte;

begin
	initatan2();

	angle := atan2(0, 0, 10, 10);

	screen_bg_col := angle;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initatan2.ras){ .md-button download }
