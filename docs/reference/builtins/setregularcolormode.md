# `SetRegularColorMode`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Switches the VIC-II back out of multicolor character mode into regular
(hi-res) character mode, the opposite of
[`SetMultiColorMode`](setmulticolormode.md).

## Syntax

    SetRegularColorMode()

## Example

```pascal
program SetRegularColorModeDemo;
begin
	SetMultiColorMode();
	screen_bg_col := black;
	Wait(100);
	SetRegularColorMode();
	screen_fg_col := light_green;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setregularcolormode.ras){ .md-button download }
