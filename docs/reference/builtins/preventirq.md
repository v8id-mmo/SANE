# `PreventIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Disables maskable interrupts, equivalent to a plain `asm(" sei");`.
Interrupts stay off until something re-enables them, typically
[`EnableIRQ`](enableirq.md) (not yet documented on this site).

## Syntax

    PreventIRQ();

## Parameters

None.

## Example

```pascal
program PreventIRQDemo;
begin
	moveto(0,0,hi(screen_char_loc));
	printstring("irqs prevented",0,40);
	PreventIRQ(); // sei: stop interrupts from firing
	// ... time-critical section would go here ...
	EnableIRQ();  // re-enable, acking the raster interrupt
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/preventirq.ras){ .md-button download }
