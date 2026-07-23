# `WaitForRaster`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Busy-waits until the VIC-II's raster beam reaches a given scan line.
The classic way to time an effect against the screen's redraw without
setting up a raster interrupt.

## Syntax

    WaitForRaster( <line> );

## Parameters

- `<line>`: the raster line to wait for, `0`-`255` (a `byte`, so lines
  256 and up on PAL/NTSC's taller total raster range aren't reachable
  through this builtin).

## Example

```pascal
program WaitForRasterDemo;
begin
	screen_bg_col := black;
	while (true) do
	begin
		waitforraster(100);
		screen_bg_col := white;
		waitforraster(120);
		screen_bg_col := black;
	end;
end.
```

[:material-download: Download this example](../../assets/examples/waitforraster.ras){ .md-button download }
