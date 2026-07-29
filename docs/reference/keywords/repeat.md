# `repeat`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
could misinterpret a program/procedure/variable name starting with
"repeat" as an unrelated inline-assembler directive; SANE no longer does.

A post-condition loop, Pascal-style: the body always runs at least once,
then the loop repeats until the paired [`until`](until.md) condition
becomes true.

## Syntax

    repeat
        <statements>
    until <condition>;

No `do`, and no `begin`/`end` needed around the body, the statement list
between `repeat` and `until` is the body.

## Parameters

- `<condition>`: checked after each pass through the body. The loop keeps
  running while this is false, and exits the moment it becomes true.

## Example

```pascal
program UntilLoopDemo;
var
	i : byte = 0;

begin
	repeat
		screen_bg_col := i;
		i := i + 1;
	until (i = 10);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/repeat.ras){ .md-button download }

## Known limitations

**Naming the program (or, seemingly, any procedure/variable) something
that starts with the literal word "repeat", case-insensitively, used to
cause an unrelated compile failure that has nothing to do with this
loop.** For example, `program RepeatDemo;` used to fail to assemble with
a "repeat count must be either 1 or 2-dimensional" error, even in a
project that never uses `repeat`/[`repend`](repend.md)'s separate
inline-assembler unrolling feature at all. The `repeat...until` loop
itself, as shown above, was always unaffected and worked correctly; the
issue was purely a naming collision with that other feature's detection
logic. See [`repend`](repend.md)'s Known limitations for the full
explanation.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the unroll-block detection now requires a line to actually match a real
`repeat <count>` shape instead of merely starting with the text "repeat",
so a program/procedure/variable name starting with "repeat" no longer
collides with it. On vanilla TRSE, simply avoiding "repeat" as the start
of a name still sidesteps it.
