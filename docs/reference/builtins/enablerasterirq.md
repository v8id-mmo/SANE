# `EnableRasterIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Turns on the VIC-II's raster-compare interrupt source, and (on the C64
and MEGA65 targets) also sets the raster line's high bit in `$D011` so
raster compares past line 255 work correctly. Used alongside
[`EnableIRQ`](enableirq.md) and `RasterIRQ` when setting up a custom
raster interrupt handler.

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
