# `initrandom`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the 8-bit pseudo-random number generator used by `Rand`.
Normally included automatically the first time `rand(` appears in the
source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initrandom();

## Example

```pascal
program InitRandomDemo;

// rand( normally auto-includes initrandom the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// 8-bit random number generator into the build.
@ignoremethod initrandom

var
	rmin, rmax, x : byte;

begin
	initrandom();

	rmin := 0;
	rmax := 255;
	rand(rmin, rmax, x);

	screen_bg_col := x;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initrandom.ras){ .md-button download }

## Known limitations

`Rand` is flagged internally as scheduled for deprecation in favor of
`Random`, but like every other compiler warning issued through a
command-line build, that notice never actually reaches the terminal or
the compiled output.
