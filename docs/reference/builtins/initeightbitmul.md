# `initeightbitmul`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the 8-bit-by-8-bit multiplication routine used whenever two
`byte` values are multiplied with `*`. Normally included automatically;
calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    initeightbitmul();

## Example

```pascal
program InitEightBitMulDemo;

// A plain byte * byte multiply auto-includes initeightbitmul the first
// time the compiler sees it. @ignoremethod opts out, so the call below is
// what actually pulls the multiply routine into the build.
@ignoremethod initeightbitmul

var
	a, b, c : byte;

begin
	initeightbitmul();

	a := 6;
	b := 7;
	c := a * b;

	screen_bg_col := c;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initeightbitmul.ras){ .md-button download }

## Known limitations

Signed `byte * byte` multiplication silently gives the wrong result for a
negative operand; see [`signed`](../keywords/signed.md).
