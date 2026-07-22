# `initprintdecimal`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the divide-by-10 routine `PrintDecimal` uses to break a number
into its individual digits before printing them. Normally included
automatically the first time `printdecimal(` appears in the source;
calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initprintdecimal();

## Example

```pascal
program InitPrintDecimalDemo;

// printdecimal( normally auto-includes initprintdecimal the first time
// it's seen. @ignoremethod opts out, so the call below is what actually
// pulls the divide-by-10 routine into the build.
@ignoremethod initprintdecimal

var
	n : integer;

begin
	initprintdecimal();

	n := 123;
	moveto(0, 0, hi(screen_char_loc));
	printdecimal(n, 3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initprintdecimal.ras){ .md-button download }
