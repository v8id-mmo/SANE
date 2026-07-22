# `NmiIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Hooks the 6502's non-maskable interrupt (NMI) vector to a given
`interrupt` procedure. Unlike a regular raster or CIA interrupt, an NMI
can't be masked with `sei`, so it fires even while normal interrupts are
disabled. On the C64 this is set up by pointing the NMI vector at the
given procedure and arming CIA #2's Timer A to fire immediately.

## Syntax

    NmiIRQ( <procedure call> );

## Parameters

- `<procedure call>`: an `interrupt` procedure, written as a call
  (`myHandler()`), whose body runs whenever the NMI fires.

## Example

```pascal
program NmiIRQDemo;
var
	nmiCount : byte = 0;

interrupt nmi();
begin
	nmiCount += 1;
	screen_bg_col := nmiCount;
end;

begin
	moveto(0,0,hi(screen_char_loc));
	printstring("nmi demo running",0,40);
	NmiIRQ(nmi());
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/nmiirq.ras){ .md-button download }
