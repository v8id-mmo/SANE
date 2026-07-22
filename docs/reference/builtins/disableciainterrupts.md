# `DisableCIAInterrupts`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Turns off the two CIA chips' timer interrupts and acknowledges any that
are already pending. This is the standard first step before installing a
custom raster interrupt: the CIA timers normally drive things like
keyboard scanning and the jiffy clock, and leaving them running alongside
a custom interrupt handler can cause it to fire at the wrong time or be
interrupted itself.

## Syntax

    DisableCIAInterrupts();

## Parameters

None.

## Example

```pascal
program DisableCIAInterruptsDemo;
var
	frameCount : byte = 0;

interrupt RasterHandler();
begin
	startirq(0);
	inc(frameCount);
	screen_bg_col := frameCount&15;
end;

begin
	DisableCIAInterrupts();
	RasterIRQ(RasterHandler(),0,0);
	EnableIRQ();
	EnableRasterIRQ();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/disableciainterrupts.ras){ .md-button download }
