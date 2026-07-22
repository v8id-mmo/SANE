# `RasterIRQ`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Hooks an `interrupt` procedure directly to a raster line: the given
procedure runs the next time the VIC-II beam reaches that line. Unlike
[`StartRasterChain`](startrasterchain.md), which is only used once to
kick off the very first raster interrupt, `RasterIRQ` is normally called
again from inside each handler to arm the *next* raster line, building a
chain of raster bars/effects across the screen.

## Syntax

    RasterIRQ( <procedure>, <line>, <mode> )

## Parameters

- `<procedure>`: an `interrupt` procedure call, e.g. `MyHandler()`.
- `<line>`: the raster line to trigger on.
- `<mode>`: a compile-time constant, `0` or `1`, selecting which
  interrupt vector to hook. `0` writes directly to the hardware IRQ
  vector (`$fffe`/`$ffff`); `1` writes to the KERNAL's own IRQ vector
  (`$0314`/`$0315`) instead, letting the KERNAL's own interrupt handler
  run as well. Most raster-effect code uses `0` together with
  [`DisableCIAInterrupts`](disableciainterrupts.md) to take over the
  interrupt entirely.

## Example

```pascal
program RasterIRQDemo;
var
	frame : byte = 0;

interrupt IRQTop();

interrupt IRQBottom();
begin
	startirq(0);
	inc(frame);
	screen_bg_col := frame;
	RasterIRQ(IRQTop(), $32, 0); // hand off to the top-of-screen handler
	CloseIRQ();
end;

interrupt IRQTop();
begin
	startirq(0);
	screen_bg_col := black;
	RasterIRQ(IRQBottom(), $c8, 0); // hand off back to the bottom handler
	CloseIRQ();
end;

begin
	disableciainterrupts();
	StartRasterChain(IRQTop(), $32, 0);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/rasterirq.ras){ .md-button download }

## Known limitations

`RasterIRQ` never validates that its first argument actually is an
interrupt procedure reference; the check exists in the source but is
disabled. Passing something else there doesn't produce a compile error,
it crashes the compiler itself with a null-pointer dereference.

`RasterIRQ` also never sets or touches the raster-compare high bit (bit
7 of `$D011`), and neither does [`EnableRasterIRQ`](enablerasterirq.md)
(which actively clears it, see that page). Between the two, there's
currently no way to arm a raster interrupt on a PAL line at or past 256
through this builtin; only lines `0`-`255` are reachable.
