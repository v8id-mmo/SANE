# `ReturnInterrupt`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Immediately ends the current `interrupt` procedure, skipping any
remaining statements in it, the correct way to exit an interrupt handler
early. An `interrupt` procedure already returns from its interrupt
automatically and correctly at its own `end;`; `ReturnInterrupt` is for
an early exit from partway through the handler instead, typically right
after a branch that already called
[`CloseIRQ`](closeirq.md)/[`CloseIRQWedge`](closeirqwedge.md) itself and
needs to stop before the rest of the handler runs too. Use this rather
than the plain [`return`](../keywords/return.md) keyword for an early
exit inside an `interrupt` procedure; see `return`'s own Known
limitations for why.

## Syntax

    ReturnInterrupt()

## Example

```pascal
program ReturnInterruptDemo;
var
	frame : byte = 0;

interrupt Raster();
begin
	startirq(0);
	inc(frame);

	if (frame > 20) then begin
		screen_bg_col := black;
		closeirq();
		returninterrupt(); // bail out immediately, skip the rest of the handler
	end;

	screen_bg_col := frame;
	closeirq();
end;

begin
	disableciainterrupts();
	startrasterchain(Raster(), 100, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/returninterrupt.ras){ .md-button download }
