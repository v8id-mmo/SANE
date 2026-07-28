# `fori`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
always ran the loop body at least once, even when the end value was
already behind the start value; SANE checks the range before entering the
loop and skips it when it's already empty.

The **inclusive** counted loop: identical to [`for`](for.md), except the
end value itself is included as the last value the loop body runs with.
Not every target system supports it; compilation fails with a clear error
if the current system doesn't.

## Syntax

    fori <var> := <start> to <end> do
        <statement>;

    fori <var> := <start> to <end> do
    begin
        <statements>;
    end;

The same `step`, `unroll`, `loopx`, `loopy`, `onpage`, `offpage` modifiers
as [`for`](for.md) are available before `do`.

## Parameters

- `<var>`: an already-declared variable used as the loop counter.
- `<start>`: the counter's initial value.
- `<end>`: the counter's final value; the body runs with `<var> = <end>`
  as its last pass.

## Example

```pascal
program ForiDemo;

var
	i : byte;
	total : byte = 0;

begin
	fori i:=0 to 255 do
		total := total + 1;
	screen_bg_col := total;
	loop();
end.
```

This loops a `byte` counter through its entire range (`0` to `255`
inclusive, 256 iterations), which is exactly the case where a plain
`for` loop can't reach the last value at all (`byte` can't hold `256` as
an end value).

[:material-download: Download this example](../../assets/examples/fori.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, `fori` shares [`for`](for.md)'s "always runs the body
at least once" behavior:** `fori i:=5 to 0 do ...` doesn't skip the loop,
it runs once and then wraps around the full counter range before
stopping. See that page for the full explanation.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`fori i:=5 to 0 do ...` now correctly skips the body entirely, the same
as [`for`](for.md).

The full-byte-range case shown in the example above (`fori i:=0 to 255
do ...`) has always terminated correctly after exactly 256 iterations, in
both TRSE and SANE, if you were worried it might suffer the same kind of
wraparound problem; it doesn't, the counter and the end-of-loop check
wrap in a way that cancels out cleanly at that particular boundary.
