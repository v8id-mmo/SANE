# `initrandom256`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the self-modifying 8-bit pseudo-random number generator used by
`Random`. Normally included automatically the first time `random(`
appears in the source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initrandom256();

## Example

```pascal
program InitRandom256Demo;

// random() normally auto-includes initrandom256 the first time it's
// seen. @ignoremethod opts out, so the call below is what actually pulls
// the 256-range random number generator into the build.
@ignoremethod initrandom256

var
	x : byte;

begin
	initrandom256();

	x := random();

	screen_bg_col := x;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initrandom256.ras){ .md-button download }
