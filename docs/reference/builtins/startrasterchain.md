# `StartRasterChain`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A one-call shortcut for the setup normally needed to kick off a raster
interrupt chain: it's exactly equivalent to calling
[`RasterIRQ`](rasterirq.md), then [`EnableRasterIRQ`](enablerasterirq.md),
then acknowledging and enabling interrupts, all in one go. Used once at
the very start of a program to arm the first raster interrupt; each
handler in the chain then re-arms the *next* one with a plain `RasterIRQ`
call.

## Syntax

    StartRasterChain( <procedure>, <line>, <mode> )

## Parameters

- `<procedure>`: an `interrupt` procedure call, e.g. `MyHandler()`.
- `<line>`: the raster line to trigger on.
- `<mode>`: a compile-time constant, `0` or `1`, selecting which
  interrupt vector to hook (same meaning as `RasterIRQ`'s `<mode>`
  parameter).

## Example

```pascal
program StartRasterChainDemo;
var
	frame : byte = 0;

interrupt Raster();
begin
	StartIRQ(0);
	inc(frame);
	screen_bg_col := frame;
	CloseIRQ();
end;

begin
	disableciainterrupts();
	// one call instead of RasterIRQ() + EnableRasterIRQ() + enableirq()
	StartRasterChain(Raster(), 100, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/startrasterchain.ras){ .md-button download }

## Known limitations

Since `StartRasterChain` is implemented as `RasterIRQ` + `EnableRasterIRQ`
back to back, it inherits both builtins' known limitations directly:

- No validation that `<procedure>` is actually an interrupt procedure
  reference; passing something else crashes the compiler itself with a
  null-pointer dereference rather than a compile error (see
  [`RasterIRQ`](rasterirq.md)).
- `EnableRasterIRQ`'s hardcoded overwrite of the VIC-II's main control
  register, which resets the vertical fine-scroll value and clears the
  raster-compare high bit (see [`EnableRasterIRQ`](enablerasterirq.md)).
  Because that high bit is never set anywhere in this chain either, a
  target `<line>` at or past 256 is currently unreachable through
  `StartRasterChain`; only `0`-`255` works.
