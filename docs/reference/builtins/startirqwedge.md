# `StartIRQWedge`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

The "wedge" counterpart to [`StartIRQ`](startirq.md): called first thing
inside a wedge-chained interrupt handler (one hooked with
[`RasterIRQWedge`](rasterirqwedge.md) instead of plain `RasterIRQ`). Burns
a short, data-dependent delay to compensate for the usual +/-1-cycle
jitter of a raster-triggered interrupt, so the next chained handler in
the wedge fires at a consistent cycle. Pairs with `CloseIRQWedge` (not
yet documented on this site), which does the matching cleanup.

## Syntax

    StartIRQWedge(cycles : byte)

## Parameters

- `cycles`: a compile-time constant delay count. The bundled tutorials
  and examples typically use small values (`5` or so); the right value
  depends on how much work the rest of the handler does before the next
  wedge link needs to fire.

## Example

```pascal
program StartIRQWedgeDemo;
var
	y : byte = 50;

@define useKernal 0

interrupt RasterBar();
begin
	StartIRQWedge(5);   // small delay, compensates for raster-read jitter
	screen_bg_col := blue;
	y := y + 4;
	if (y > 240) then
		y := 50;

	RasterIRQWedge(RasterBar(), y, @useKernal); // re-arm for the next band

	closeirqwedge();
end;

begin
	preventirq();
	disableciainterrupts();
	SetMemoryConfig(1, @useKernal, 0);
	StartRasterChain(RasterBar(), y, @useKernal);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/startirqwedge.ras){ .md-button download }

## Known limitations

`StartIRQWedge` doesn't validate that its `cycles` argument is actually a
compile-time constant before reading its value. Passing a variable or
other non-constant expression there doesn't produce a compile error, it
crashes the compiler itself with a null-pointer dereference (its sibling
`StartIRQ` correctly rejects a non-constant argument with a clean
error; `StartIRQWedge` doesn't do the same check).
