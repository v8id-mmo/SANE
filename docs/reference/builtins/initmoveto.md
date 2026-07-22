# `initmoveto`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the cursor-positioning routine used by `MoveTo`, `PrintString`,
and `Tile` to translate an `(x, y)` position into a screen memory address.
Normally included automatically the first time one of those is seen in
the source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initmoveto();

## Example

```pascal
program InitMovetoDemo;

// moveto(/printstring(/tile( normally auto-include initmoveto the first
// time one of them is seen. @ignoremethod opts out, so the call below is
// what actually pulls the cursor-positioning routine into the build.
@ignoremethod initmoveto

begin
	initmoveto();

	moveto(0, 0, hi(screen_char_loc));
	printstring("hello", 0, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initmoveto.ras){ .md-button download }
