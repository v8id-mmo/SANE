# `unroll`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE's `unroll` always treats the end value as exclusive, even on a
`fori` loop; SANE's now matches `fori`'s own inclusive semantics.

A [`for`](for.md)/[`fori`](fori.md) loop modifier that expands the loop at
compile time instead of generating a runtime loop: the body is emitted
once per iteration, back to back, with the loop variable replaced by the
actual literal value for that pass. This trades code size for speed (and
for removing the loop-counter overhead entirely), which matters most in
cycle-sensitive code like raster interrupt handlers.

## Syntax

    for <var> := <start> to <end> unroll do
        <statement>;

## Parameters

- `<start>`, `<end>`: both must be constant, compile-time-known values,
  not variables or runtime expressions; unrolling has to know exactly how
  many copies of the body to emit while compiling.

## Example

```pascal
program UnrollDemo;
var
	i : byte;
	total : byte = 0;

begin
	for i:=0 to 4 unroll do
		total := total + 1;
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/unroll.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, on `fori`, `unroll` always treats the end value as
exclusive, silently dropping the loop's last, inclusive pass.**
[`fori`](fori.md)'s whole point versus plain `for` is that
`fori i:=0 to 3 do ...` runs with `i = 0, 1, 2, 3` (the end value
included). Adding `unroll` to a `fori` loop there breaks that guarantee:
`fori i:=0 to 3 unroll do screen_bg_col := i;` only emits 3 copies of the
body (for `0`, `1`, `2`), not 4. Unrolling doesn't look at whether the
loop was written as `for` or `fori` at all, it always expands `<start>`
up to, but not including, `<end>`. A plain (non-unrolled) `fori` loop is
unaffected and always correctly includes the end value.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`unroll` on a `fori` loop now includes the end value, matching a
non-unrolled `fori` loop.
