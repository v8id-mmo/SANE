# `EnableRasterIRQ`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
overwrote the whole VIC-II main control register with a fixed value on
top of enabling the raster IRQ; SANE no longer touches that register at
all here, since raster-IRQ-enable lives entirely in a separate register.

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

**In vanilla TRSE, besides the raster-interrupt-enable bit,
`EnableRasterIRQ` also overwrites the VIC-II's entire main control
register with one fixed value, instead of changing only the bit it
actually needs.** This silently resets the vertical fine-scroll value,
turns off bitmap/extended-color mode, and clears the raster-compare high
bit, regardless of anything set up beforehand (see
[`SetBitmapMode`](setbitmapmode.md), which has the same issue on vanilla
TRSE). [`StartRasterChain`](startrasterchain.md) calls `EnableRasterIRQ`
internally, so it inherits this exact side effect too on vanilla TRSE.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`EnableRasterIRQ` now only sets the raster-interrupt-enable bit; it no
longer touches the VIC-II's main control register at all, so a vertical
fine-scroll value or bitmap/extended-color mode set up beforehand
survives a call to it, and `StartRasterChain` shares this fix.

**A raster line of 256 or higher is still unreachable through this whole
builtin family, in both TRSE and SANE.** Nothing in
`EnableRasterIRQ`/`RasterIRQ`/`StartRasterChain` sets the raster-compare
high bit needed to arm a line that far down the screen; only lines
`0`-`255` can currently be targeted. Still open.
