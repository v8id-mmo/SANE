# `WaitNoRaster`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Busy-waits for a given number of raster lines to pass, counting from
wherever the beam currently is (rather than from a fixed line, as
[`WaitForRaster`](waitforraster.md) does). Handy for stacking several
timed delays back to back, e.g. drawing a stack of raster color bars in
the main loop without an interrupt.

## Syntax

    WaitNoRaster( <lines> );

## Parameters

- `<lines>`: how many raster lines to wait for, as a `byte`.

## Example

```pascal
program WaitNoRasterDemo;
begin
	while (true) do
	begin
		// Simple raster bars: stack three background colors without
		// ever needing a raster interrupt.
		waitforverticalblank();
		screen_bg_col := blue;
		waitnoraster(60);
		screen_bg_col := light_blue;
		waitnoraster(20);
		screen_bg_col := white;
		waitnoraster(20);
		screen_bg_col := black;
	end;
end.
```

[:material-download: Download this example](../../assets/examples/waitnoraster.ras){ .md-button download }
