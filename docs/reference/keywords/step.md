# `step`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

An optional modifier on a [`for`](for.md)/[`fori`](fori.md) loop header
that sets how much the loop counter advances by each pass, instead of the
default of `1`.

## Syntax

    for <var> := <start> to <end> step <amount> do
        <statement>;

## Parameters

- `<amount>`: how much to add to the loop counter after each pass. Can be
  any expression, not just a literal number.

## Example

```pascal
program StepDemo;

var
	i : byte;
	total : byte = 0;

begin
	for i:=0 to 10 step 2 do
		total := total + i;
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/step.ras){ .md-button download }

## Known limitations

**A `step` that doesn't evenly divide into the loop's range can cause the
counter to skip right over the end value and keep going until it wraps
around the full range.** As with plain `for`/`fori` (see [`for`](for.md)'s
Known limitations), the loop only checks whether the counter has landed
*exactly* on the end value, never whether it's passed it. With `step 2`
this is easy to avoid by keeping the range even, but a step like `step 3`
on `for i:=0 to 10 ...` never actually lands on `10` (it goes
`0, 3, 6, 9, 12, ...`), so the loop runs far longer than intended, wrapping
all the way around before it happens to land back on `10` again.
