# `StartIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Called first thing inside a custom interrupt handler to save the
registers the KERNAL/hardware doesn't already save, and to acknowledge
the interrupt so it can fire again. Pairs with
[`CloseIRQ`](closeirq.md), which does the matching cleanup and returns.

## Syntax

    StartIRQ(useKernal : byte)

## Parameters

- `useKernal`: a compile-time constant, `0` or `1`, matching whatever
  mode the interrupt was originally hooked with (see
  [`RasterIRQ`](rasterirq.md)/[`StartRasterChain`](startrasterchain.md)'s
  own `mode` parameter). `1` means the KERNAL's own interrupt entry
  already pushed the registers, so `StartIRQ` only needs to acknowledge
  the interrupt; `0` means `StartIRQ` needs to push them itself first.

## Example

```pascal
program StartIRQDemo;
var
	frame : byte = 0;

interrupt Raster();
begin
	StartIRQ(0);   // must match the mode given to StartRasterChain below
	inc(frame);
	screen_bg_col := frame;
	CloseIRQ();
end;

begin
	disableciainterrupts();
	StartRasterChain(Raster(), 100, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/startirq.ras){ .md-button download }
