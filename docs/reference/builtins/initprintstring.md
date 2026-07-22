# `initprintstring`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the character-copy loop `PrintString` and `PrintNumber` use to
write text to screen memory. Normally included automatically the first
time `printstring(` or `printnumber(` appears in the source; calling it
directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initprintstring();

## Example

```pascal
program InitPrintStringDemo;

// printstring(/printnumber( normally auto-include initprintstring the
// first time one of them is seen. @ignoremethod opts out, so the call
// below is what actually pulls the printing routine into the build.
@ignoremethod initprintstring

begin
	initprintstring();

	printstring("hi", 0, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initprintstring.ras){ .md-button download }
