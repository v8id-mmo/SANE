# Simple color raster bars

A classic, approachable introduction to raster interrupts: four handlers
chained together, each painting a different background color band down
the screen, redrawn every single frame.

## What this uses

- [`interrupt`](../reference/keywords/interrupt.md) - declares each
  handler procedure.
- [`DisableCIAInterrupts`](../reference/builtins/disableciainterrupts.md) -
  standard first step before installing a custom raster interrupt.
- [`StartRasterChain`](../reference/builtins/startrasterchain.md) - arms
  the very first raster interrupt.
- [`RasterIRQ`](../reference/builtins/rasterirq.md) - re-arms the next
  handler in the chain from inside each one.
- [`StartIRQ`](../reference/builtins/startirq.md) /
  [`CloseIRQ`](../reference/builtins/closeirq.md) - the required
  save/restore pair at the start and end of every handler.

```pascal
program RasterBars;

// Four handlers, each one armed to fire at a different raster line, each
// re-arming the next one in the chain. Together they paint four bands of
// background color down the screen, redrawn every single frame.

interrupt Bar1();
interrupt Bar2();
interrupt Bar3();
interrupt Bar4();

interrupt Bar1();
begin
	startirq(0);
	screen_bg_col := red;
	RasterIRQ(Bar2(),80,0); // arm the next band down
	closeirq();
end;

interrupt Bar2();
begin
	startirq(0);
	screen_bg_col := yellow;
	RasterIRQ(Bar3(),120,0);
	closeirq();
end;

interrupt Bar3();
begin
	startirq(0);
	screen_bg_col := green;
	RasterIRQ(Bar4(),160,0);
	closeirq();
end;

interrupt Bar4();
begin
	startirq(0);
	screen_bg_col := blue;
	RasterIRQ(Bar1(),40,0); // loop back to the top band for the next frame
	closeirq();
end;

begin
	clearscreen(key_space,screen_char_loc);

	// Standard setup before installing a custom raster interrupt: turn off
	// the CIA timers, then arm the very first band in the chain.
	disableciainterrupts();
	StartRasterChain(Bar1(),40,0);

	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/raster-bars.ras){ .md-button download }

## How it works

Each `interrupt` procedure fires the instant the VIC-II's raster beam
reaches the line it was armed for, changes `screen_bg_col`, then arms
the *next* handler at the *next* line before returning, building a
chain that covers the whole screen once per frame. `Bar4`, the last one
in the chain, re-arms `Bar1` back at the top instead of a new line
further down, which is what makes the four bands repeat every frame
instead of only appearing once. `StartIRQ(0)`/`CloseIRQ()` at the start
and end of every handler save and restore the registers the hardware
doesn't already save for you; skipping them corrupts whatever the main
program was doing at the moment the interrupt fired. `DisableCIAInterrupts`
is called once up front so the CIA's own timer interrupts don't fire in
the middle of this chain and disturb its timing.
