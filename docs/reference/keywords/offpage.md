# `offpage`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
had two gaps in forced-page handling on this keyword (no effect at all on
`case`, not usable on `repeat...until` at all); SANE fixes both.

A manual override on `if`, `while`, `for`, or `case`, forcing the compiler
to generate a long jump instead of a short relative branch for that
statement's condition, regardless of how big the block actually turns out
to be. See [`onpage`](onpage.md) for the opposite override.

Normally the compiler measures the generated code and picks a short
relative branch when the block is small enough, falling back to a long
jump automatically when it isn't. `offpage` exists for the cases where
that automatic choice needs to be overridden by hand, most commonly when a
block that looks small in source ends up being pushed out of relative-jump
range by another compiler pass (like the post-optimizer) after the
automatic check already ran.

## Syntax

    if <condition> offpage then
      ...

    while <condition> offpage do
      ...

    for <var> := <start> to <end> [step <n>] offpage do
      ...

    case <expression> offpage of
      ...
    end;

    repeat
      ...
    until <condition> offpage;

The `case` and `repeat...until` forms only actually take effect on SANE;
see Known limitations below for their vanilla TRSE behavior.

## Example

```pascal
program OffpageDemo;
var
	i : byte;

begin
	for i := 0 to 255 do
	begin
		if i = 128 offpage then
		begin
			screen_bg_col := white;
		end;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/offpage.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, has no effect at all on a `case` statement.** `case
<expr> offpage of ...` parses without error, but the generated comparison
code is unaffected either way; `offpage` on a `case` is a silent no-op.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`case <expression> offpage of ...` now actually forces the long-jump
form.

**In vanilla TRSE, not usable on `repeat...until` at all**, even though
the code generator has dedicated handling for it there. Writing `until
<condition> offpage;` produces a confusing, misplaced parse error rather
than the long-jump override actually taking effect; the keyword simply
isn't wired up to be read at that position.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`until <condition> offpage;` now parses and applies the override
correctly; the code generator already had full, working support for it,
it just couldn't be reached from valid source before this fix.
