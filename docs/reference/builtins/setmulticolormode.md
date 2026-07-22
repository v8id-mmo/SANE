# `SetMultiColorMode`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Switches the VIC-II into multicolor character mode, where each character
cell can show up to four colors (background, two shared multicolor
registers, and its own color) at half the usual horizontal resolution.

## Syntax

    SetMultiColorMode()

## Example

```pascal
program SetMultiColorModeDemo;
begin
	SetMultiColorMode();
	screen_bg_col := black;
	screen_fg_col := light_blue;
	multicolor_char_col := grey;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setmulticolormode.ras){ .md-button download }
