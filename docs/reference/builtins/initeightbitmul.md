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

A `byte * byte` multiplication that stays a `byte` result (as in the
example above) is always correct regardless of sign, in both TRSE and
SANE: a two's-complement product's low byte is identical whether the
inputs are interpreted as signed or unsigned. Signed multiplication only
actually misbehaves once the product widens to an `integer`; see
[`*`](../operators/multiplication.md)'s Known limitations.
