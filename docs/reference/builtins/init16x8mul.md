# `init16x8mul`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the 16-bit-by-8-bit multiplication routine used whenever an
`integer` is multiplied by a `byte`. Normally included automatically;
calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    init16x8mul();

## Example

```pascal
program Init16x8MulDemo;

// A 16-bit-by-8-bit multiply (integer * byte) auto-includes init16x8mul
// the first time the compiler sees it. @ignoremethod opts out, so the
// call below is what actually pulls the multiply routine into the build.
@ignoremethod init16x8mul

var
	a : integer;
	b : byte;
	c : integer;

begin
	init16x8mul();

	a := 300;
	b := 3;
	c := a * b;

	screen_bg_col := lo(c);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/init16x8mul.ras){ .md-button download }
