# `EnableIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Acknowledges the VIC-II's raster interrupt flag and re-enables interrupts
(`cli`). Used together with [`EnableRasterIRQ`](enablerasterirq.md) and
`RasterIRQ` when setting up a custom raster interrupt handler: `RasterIRQ`
points the interrupt vector at the handler, `EnableRasterIRQ` turns on the
VIC-II's raster interrupt source, and `EnableIRQ` clears any stale
pending flag and lets interrupts actually start firing.

## Syntax

    EnableIRQ();

## Parameters

None.

## Example

```pascal
program EnableIRQDemo;
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

[:material-download: Download this example](../../assets/examples/enableirq.ras){ .md-button download }
