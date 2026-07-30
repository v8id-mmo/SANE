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

**`wedge` compiles to exactly the same code as [`interrupt`](interrupt.md),
with no distinct behavior of its own.** Comparing the generated assembly
for equivalent `wedge` and `interrupt` declarations shows identical
output (same body, same trailing interrupt return). In real C64
terminology, a "wedge" specifically means chaining onto an
already-installed interrupt vector instead of replacing it outright, and
this compiler does have that behavior, but it lives entirely in the
separate [`RasterIRQWedge`](../builtins/rasterirqwedge.md)/
[`StartIRQWedge`](../builtins/startirqwedge.md)/
[`CloseIRQWedge`](../builtins/closeirqwedge.md) builtin functions,
unrelated to this declaration keyword. This is treated as an intentional
alias, not a defect: `wedge` is just an alternate spelling of `interrupt`
at the declaration level, and a procedure needs those builtins to
actually chain onto an interrupt vector regardless of which keyword
declared it. Use `interrupt` and `wedge` interchangeably; reach for the
builtins above for actual vector chaining.
