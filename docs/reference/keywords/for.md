# `for`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A counted loop: runs a block of code once per value of a loop variable,
counting up from a start value to an end value. `for` is the **exclusive**
form: the end value itself is not included. See [`fori`](fori.md) for the
inclusive variant.

## Syntax

    for <var> := <start> to <end> do
        <statement>;

    for <var> := <start> to <end> do
    begin
        <statements>;
    end;

`step`, `unroll`, `loopx`, `loopy`, `onpage`, and `offpage` modifiers can
appear between the `to <end>` and `do`, for example
`for i:=0 to 10 step 2 do ...`.

## Parameters

- `<var>`: an already-declared variable used as the loop counter.
- `<start>`: the counter's initial value.
- `<end>`: the counter stops once it would reach this value; the last
  value the body actually runs with is `<end> - 1` (or `<end> - step` with
  a custom step).

## Example

```pascal
program ForDemo;

var
	i : byte;
	total : byte = 0;

begin
	for i:=0 to 10 do
		total := total + i;
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/for.ras){ .md-button download }

## Known limitations

**The loop body always runs at least once, even if the end value is
already behind the start value.** `for`/`fori` don't check the range
before entering the loop, only after each pass through the body. So
`for i:=5 to 0 do ...` doesn't just skip the loop like a typical exclusive
range would; it runs the body once with `i=5`, then keeps counting up and
wrapping around the full byte range until the counter happens to land back
on the end value again, running far more times than intended (roughly 250
extra iterations for a byte counter). If the end value can be smaller than
the start value at runtime, guard the loop with an explicit `if` first.
