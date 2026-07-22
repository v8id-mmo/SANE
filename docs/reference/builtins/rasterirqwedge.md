# `RasterIRQWedge`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

The "wedge" counterpart to [`RasterIRQ`](rasterirq.md): hooks an
`interrupt` procedure to a raster line the same way, but through the
wedge-chaining mechanism (`StartIRQWedge`/`CloseIRQWedge`, not yet
documented on this site) instead of a plain hardware or KERNAL vector.
Used to add a raster-triggered handler onto an existing interrupt chain
without displacing whatever else is already hooked to it, the technique
several of the bundled multi-band raster-bar effects rely on.

## Syntax

    RasterIRQWedge( <procedure>, <line>, <mode> )

## Parameters

- `<procedure>`: an `interrupt` procedure call, e.g. `MyHandler()`.
- `<line>`: the raster line to trigger on.
- `<mode>`: a compile-time constant. Only `0` (hardware IRQ vector) is
  actually implemented; see Known limitations below.

## Example

```pascal
program RasterIRQWedgeDemo;
var
	y : byte = 50;

@define useKernal 0

interrupt RasterBar();
begin
	StartIRQWedge(5);
	screen_bg_col := blue;
	y := y + 4;
	if (y > 240) then
		y := 50;

	RasterIRQWedge(RasterBar(), y, @useKernal); // re-arm for the next band

	closeirqwedge();
end;

begin
	preventirq();
	disableciainterrupts();
	SetMemoryConfig(1, @useKernal, 0);
	StartRasterChain(RasterBar(), y, @useKernal);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/rasterirqwedge.ras){ .md-button download }

## Known limitations

The `<mode>` parameter only supports `0` (hooking the hardware IRQ
vector directly). Passing `1` to route through the KERNAL's own IRQ
vector instead, the way plain `RasterIRQ` supports, is a hard compile
error: "Kernal wedge not implemented." Every real usage of this builtin,
in this fork's own bundled tutorials included, passes `0`.
