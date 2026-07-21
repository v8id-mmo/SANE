# `offpage`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

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

**Has no effect at all on a `case` statement.** `case <expr> offpage of
...` parses without error, but the generated comparison code is unaffected
either way; `offpage` on a `case` is a silent no-op on this compiler
target.

**Not usable on `repeat...until` at all**, even though the code generator
has dedicated handling for it there. Writing `until <condition> offpage;`
produces a confusing, misplaced parse error rather than the long-jump
override actually taking effect; the keyword simply isn't wired up to be
read at that position.
