# `wedge`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a procedure the same way [`interrupt`](interrupt.md) does: used
in place of `procedure`, and compiled with an interrupt-return instruction
at the end instead of a normal one, so it can be installed as an IRQ/raster
interrupt handler.

## Syntax

    wedge <name>();
    begin
      ...
    end;

## Parameters

None beyond the procedure's own declaration.

## Example

```pascal
program WedgeDemo;
var
	frameCount : byte = 0;

wedge RasterHandler();
begin
	startirq(0);
	inc(frameCount);
	screen_bg_col := frameCount&15;
end;

begin
	RasterIRQ(RasterHandler(),0,0);
	EnableIRQ();
	EnableRasterIRQ();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/wedge.ras){ .md-button download }

## Known limitations

**`wedge` currently compiles to exactly the same code as
[`interrupt`](interrupt.md), with no distinct behavior of its own.**
Comparing the generated assembly for equivalent `wedge` and `interrupt`
declarations shows identical output (same body, same trailing interrupt
return). In real C64 terminology, a "wedge" specifically means chaining
onto an already-installed interrupt vector instead of replacing it
outright, and this compiler does have that behavior, but it lives
entirely in the separate `rasterirqwedge()`/`startirqwedge()`/
`closeirqwedge()` builtin functions, unrelated to this declaration
keyword. Declaring a procedure with `wedge` instead of `interrupt` doesn't
make it chain onto anything by itself; it needs those builtins regardless
of which keyword declared the procedure.
