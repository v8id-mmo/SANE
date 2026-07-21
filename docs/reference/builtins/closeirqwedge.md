# `CloseIRQWedge`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The counterpart to [`CloseIRQ`](closeirq.md) used with the raster-IRQ
"wedge" chaining mechanism (`StartIRQWedge`/`RasterIRQWedge`, not yet
documented on this site). It acknowledges the current raster interrupt
and restores `A`, `X`, and `Y`, right before an `interrupt` procedure
started this way returns.

## Syntax

    CloseIRQWedge();

## Parameters

None.

## Example

```pascal
program CloseIRQWedgeDemo;
var
	y, idx, tt : byte = 0;
	colorsRedhues : array[] of byte = (6,11,15,1,7,8,2,2,2,2,2,8,7,1,15,11,6);

@define useKernal 0

interrupt RasterBar();

interrupt RasterTop();
begin
	StartIRQ(@useKernal);
	screen_fg_col := blue;
	screen_bg_col := blue;
	idx := 0;
	tt += 2;
	y := sine[tt]/4 + 80;

	RasterIRQWedge(RasterBar(), y, @useKernal);
	CloseIRQ();
end;

interrupt RasterBar();
begin
	idx += 1;
	StartIRQWedge(5);
	screen_bg_col := colorsRedhues[idx];
	screen_fg_col := screen_bg_col;
	y := y + 6;

	RasterIRQWedge(RasterBar(), y, @useKernal);

	if (idx = 16) then // back to the top band
		RasterIRQ(RasterTop(), 0, @useKernal);

	closeirqwedge(); // acks the raster IRQ and restores registers pushed by StartIRQWedge's chain
end;

begin
	preventirq();
	disableciainterrupts();
	SetMemoryConfig(1, @useKernal, 0);
	StartRasterChain(RasterTop(), 0, @useKernal);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/closeirqwedge.ras){ .md-button download }

## Known limitations

Only use it to close a handler that was entered through the
wedge-chaining path (`StartIRQWedge`); a handler started with plain
`StartIRQ` should close with plain [`CloseIRQ`](closeirq.md) instead, as
shown by `RasterTop` in the example above.
