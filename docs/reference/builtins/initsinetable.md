# `initsinetable`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE's
auto-init only triggered off a `sine[` usage in the currently-compiled
file's own text; SANE also picks up a usage inside a `@use`d unit.

Computes a 256-byte sine lookup table at program start, read by `sine[]`.
Normally included and run automatically the first time `sine[` appears in
the source; calling it directly, together with
[`@ignoremethod`](../directives/ignoremethod.md), lets a program take
manual control of when it runs.

## Syntax

    initsinetable();

## Example

```pascal
program InitSinetableDemo;

// sine[ normally auto-includes initsinetable the first time it's seen.
// @ignoremethod opts out, so the call below is what actually fills the
// 256-byte sine table before it's read.
@ignoremethod initsinetable

var
	angle : byte;
	x : byte;

begin
	initsinetable();

	angle := 64;
	x := sine[angle];

	screen_bg_col := x;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initsinetable.ras){ .md-button download }

## Known limitations

Unlike most other auto-initialized builtins, `initsinetable` genuinely
needs to run once, at program start, to fill the table before anything
reads from it; it isn't just a subroutine that gets called on demand. **In
vanilla TRSE, if `sine[` is only ever used from inside a `use`d unit
file, with no matching usage anywhere in the main program's own text,
the automatic call to this routine never gets inserted, the table is
never filled, and `sine[angle]` silently returns `0` for every angle
instead of failing to compile.** Calling `initsinetable()` explicitly (as
in the example above) sidesteps this on vanilla TRSE too, since it
doesn't depend on the text scan. :material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a `sine[` usage anywhere in the program, including inside a `use`d unit
file, now correctly triggers the automatic call; calling
`initsinetable()` explicitly together with
[`@ignoremethod`](../directives/ignoremethod.md) is still useful for
taking manual control of exactly when the table gets filled.
