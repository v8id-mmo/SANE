# `CloseIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Restores the `A`, `X`, and `Y` registers at the end of an interrupt
handler, undoing the save that `StartIRQ` (not yet documented on this
site) performs at the top of the same handler. Called as the last
statement in an `interrupt` procedure, right before it returns. See
[`CloseIRQWedge`](closeirqwedge.md) for the variant used with the
raster-IRQ "wedge" chaining mechanism instead.

## Syntax

    CloseIRQ();

## Parameters

None.

## Example

```pascal
program CloseIRQDemo;
var
	frame : byte = 0;

interrupt Raster();
begin
	startirq(0);
	inc(frame);
	screen_bg_col := frame;
	closeirq();
end;

begin
	disableciainterrupts();
	startrasterchain(Raster(), 100, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/closeirq.ras){ .md-button download }
