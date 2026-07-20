# `repeat`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A post-condition loop, Pascal-style: the body always runs at least once,
then the loop repeats until the paired `until` condition becomes true.

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
that starts with the literal word "repeat", case-insensitively, can cause
an unrelated compile failure that has nothing to do with this loop.** For
example, `program RepeatDemo;` fails to assemble with a "repeat count must
be either 1 or 2-dimensional" error, even in a project that never uses
`repeat`/[`repend`](repend.md)'s separate inline-assembler unrolling
feature at all. The `repeat...until` loop itself, as shown above, is
completely unaffected and works correctly; the issue is purely a naming
collision with that other feature's detection logic. See
[`repend`](repend.md)'s Known limitations for the full explanation.
Simply avoiding "repeat" as the start of a name sidesteps it.
