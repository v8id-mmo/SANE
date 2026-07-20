# `interrupt`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a procedure as an interrupt handler instead of an ordinary
procedure. It's used exactly like `procedure`, but the compiler ends the
generated routine with an interrupt return instruction instead of a normal
one, so it can be installed as an IRQ/raster interrupt handler.

## Syntax

    interrupt <name>();
    begin
      ...
    end;

## Parameters

None beyond the procedure's own declaration.

## Example

```pascal
program InterruptDemo;
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

[:material-download: Download this example](../../assets/examples/interrupt.ras){ .md-button download }
