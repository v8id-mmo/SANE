# `onpage`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
had three separate gaps in forced-page handling on this keyword (no
safety check when forcing it on an oversized `if`/`while`/`for` block, no
effect at all on `case`, not usable on `repeat...until` at all); SANE
fixes all three.

A manual override on `if`, `while`, `for`, or `case`, forcing the compiler
to use a short relative branch for that statement's condition, even if its
own size check would otherwise have chosen a long jump. The opposite of
[`offpage`](offpage.md); see that page for the normal automatic behavior
this is overriding.

## Syntax

    if <condition> onpage then
      ...

    while <condition> onpage do
      ...

    for <var> := <start> to <end> [step <n>] onpage do
      ...

    case <expression> onpage of
      ...
    end;

    repeat
      ...
    until <condition> onpage;

The `case` and `repeat...until` forms only actually take effect on SANE;
see Known limitations below for their vanilla TRSE behavior.

## Example

```pascal
program OnpageDemo;
var
	i : byte;

begin
	for i := 0 to 10 do
	begin
		if i = 5 onpage then
		begin
			screen_bg_col := white;
		end;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/onpage.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, no safety check backs this up on `if`/`while`/`for`.**
Forcing `onpage` tells the compiler to emit a short relative branch
unconditionally; if the block turns out too large for that branch's
range, nothing catches the mistake at compile time (the block still gets
measured, but a forced `onpage` silently overrides that measurement
either way). In practice, real code in this project only ever reaches for
[`offpage`](offpage.md) (the safe direction) and never `onpage`, for
exactly this reason. On real hardware this doesn't fail completely
silently: OrgAsm's own assembler-stage range check still catches the
resulting out-of-range branch, but only late, with a confusing error
reported against a generated internal label rather than the `onpage`
keyword itself.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
forcing `onpage` on a block too large for a short relative branch now
raises a clear compile-time error pointing at the `onpage` keyword's own
line, instead of only being caught later by the assembler (or not at
all).

**In vanilla TRSE, has no effect at all on a `case` statement**, the same
silent no-op documented on the [`offpage`](offpage.md) page.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`case <expression> onpage of ...` now actually forces the short-branch
form, same as on `if`/`while`/`for`.

**In vanilla TRSE, not usable on `repeat...until`.** `until <condition>
onpage;` desyncs the parser instead of applying the override, same as
`offpage` in that position.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`until <condition> onpage;` now parses and applies the override
correctly; the code generator already had full, working support for it,
it just couldn't be reached from valid source before this fix.
