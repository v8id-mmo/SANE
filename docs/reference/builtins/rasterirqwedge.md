# `RasterIRQWedge`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE never validated `<procedure>` or `<mode>` before dereferencing them,
crashing the compiler on a malformed call; SANE adds both checks. Vanilla
TRSE also never actually got this builtin to produce a working build in
any mode; see Known limitations below.

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

**In vanilla TRSE, the `<mode>` parameter only supports `0` (hooking the
hardware IRQ vector directly).** Passing `1` to route through the
KERNAL's own IRQ vector instead, the way plain `RasterIRQ` supports, is a
hard compile error: "Kernal wedge not implemented." Every real usage of
this builtin, in this fork's own bundled tutorials included, passes `0`
for exactly this reason.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`<mode>` of `1` now writes the handler's address into the KERNAL's own
IRQ vector, the same way `RasterIRQ`'s own KERNAL-vector mode already
did; both modes work now.

**In vanilla TRSE, `RasterIRQWedge` never actually produced a working
build, in either mode.** Found while fixing the KERNAL-vector-mode gap
above: every use of this builtin, in any mode, pulls in a small shared
routine that reschedules the next raster trigger on every interrupt; that
routine referenced a nonexistent register name instead of the raster-line
hardware register it actually needed to read back, so assembly failed
the moment `RasterIRQWedge` was used at all, hardware-vector mode
included.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the shared rescheduling routine now reads the raster line back from the
correct hardware register, so both modes assemble and produce a working
build.

**In vanilla TRSE, neither `<procedure>` nor `<mode>` is actually
validated before use**: passing something other than an interrupt
procedure reference as the first argument, or a non-constant expression
as `<mode>`, doesn't produce a compile error, it crashes the compiler
itself with a null-pointer dereference (see [`RasterIRQ`](rasterirq.md),
which has the same gap on its own first argument).

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
both arguments are now validated (a procedure-reference check on
`<procedure>`, a pure-numeric check on `<mode>`), so a malformed call
produces a clean compile error instead of crashing the compiler.
