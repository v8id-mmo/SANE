# `init16x8div`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Includes the 16-bit-by-8-bit division routine used whenever an `integer`
gets divided, and by `mod16`. Normally included automatically;
calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it's pulled into the build.

## Syntax

    init16x8div();

## Example

```pascal
program Init16x8DivDemo;

// mod16(a,b) triggers the compiler to auto-include init16x8div the first
// time it's seen. @ignoremethod opts out of that, so the call below is
// what actually pulls the division routine into the build.
@ignoremethod init16x8div

var
	a : integer;
	r : byte;

begin
	init16x8div();

	a := 1000;
	r := mod16(a, 7);

	screen_bg_col := r;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/init16x8div.ras){ .md-button download }
