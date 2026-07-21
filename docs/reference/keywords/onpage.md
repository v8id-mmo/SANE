# `onpage`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

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

**No safety check backs this up on `if`/`while`/`for`.** Forcing `onpage`
tells the compiler to emit a short relative branch unconditionally; if the
block turns out too large for that branch's range, nothing catches the
mistake at compile time. In practice, real code in this project only ever
reaches for [`offpage`](offpage.md) (the safe direction) and never
`onpage`, for exactly this reason.

**Has no effect at all on a `case` statement**, the same silent no-op
documented on the [`offpage`](offpage.md) page.

**Not usable on `repeat...until`.** `until <condition> onpage;` desyncs the
parser instead of applying the override, same as `offpage` in that
position.
