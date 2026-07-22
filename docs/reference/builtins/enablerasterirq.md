# `EnableRasterIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Turns on the VIC-II's raster-compare interrupt source. Used alongside
[`EnableIRQ`](enableirq.md) and [`RasterIRQ`](rasterirq.md) when setting
up a custom raster interrupt handler.

## Syntax

    EnableRasterIRQ();

## Parameters

None.

## Example

```pascal
program EnableRasterIRQDemo;
var
	frameCount : byte = 0;

interrupt RasterHandler();
begin
	startirq(0);
	inc(frameCount);
	screen_bg_col := frameCount&15;
end;

begin
	RasterIRQ(RasterHandler(),0,0);
	EnableIRQ();
	EnableRasterIRQ();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/enablerasterirq.ras){ .md-button download }

## Known limitations

Besides the raster-interrupt-enable bit, `EnableRasterIRQ` also
overwrites the VIC-II's entire main control register with one fixed
value, instead of changing only the bit it actually needs. This silently
resets the vertical fine-scroll value, turns off bitmap/extended-color
mode, and clears the raster-compare high bit, regardless of anything set
up before it (see [`SetBitmapMode`](setbitmapmode.md), which has the
same issue). [`StartRasterChain`](startrasterchain.md) calls
`EnableRasterIRQ` internally, so it inherits this exact side effect too.

That clearing of the raster-compare high bit isn't just a side effect
of an otherwise-correct feature, either: nothing in
`EnableRasterIRQ`/`RasterIRQ`/`StartRasterChain` ever *sets* that bit in
the first place. A raster interrupt on a PAL line at or past 256 is
currently unreachable through this whole builtin family; only lines
`0`-`255` can actually be targeted.
