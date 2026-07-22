# `initBcd`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the digit-plotting routine used by [`BcdPrint`](bcdprint.md).
Normally included automatically the first time `bcdprint(` appears in the
source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initbcd();

## Example

```pascal
program InitBcdDemo;

// bcdprint( normally auto-includes initBcd the first time it's seen.
// @ignoremethod opts out, so the call below is what actually pulls the
// digit-plotting routine into the build.
@ignoremethod initbcd

var
	score : array[] of byte = ($12, $34);

begin
	DefineScreen();
	screenmemory := screen_char_loc;

	initbcd();

	moveto(0, 0, hi(screen_char_loc));
	BcdPrint(#score, 2);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initbcd.ras){ .md-button download }
