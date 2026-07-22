# `init8x8div`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the 8-bit-by-8-bit division routine used whenever two `byte`
values are divided with `/`. Normally included automatically; calling it
directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    init8x8div();

## Example

```pascal
program Init8x8DivDemo;

// A plain byte/byte division auto-includes init8x8div the first time the
// compiler sees it. @ignoremethod opts out, so the call below is what
// actually pulls the division routine into the build.
@ignoremethod init8x8div

var
	a, b, c : byte;

begin
	init8x8div();

	a := 100;
	b := 7;
	c := a / b;

	screen_bg_col := c;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/init8x8div.ras){ .md-button download }

## Known limitations

`byte / byte` division is always unsigned, regardless of whether either
operand is declared `signed`; see [`signed`](../keywords/signed.md).
