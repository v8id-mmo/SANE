# `SetBitmapMode`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Switches the VIC-II from character (text) mode into bitmap mode.

## Syntax

    SetBitmapMode()

## Example

```pascal
program SetBitmapModeDemo;
begin
	SetBitmapMode();
	SetScreenLocation($4400);
	SetCharsetLocation($6000);   // bitmap data base address
	SetBank(vic_bank1);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setbitmapmode.ras){ .md-button download }

## Known limitations

`SetBitmapMode` overwrites the entire VIC-II control register with one
fixed value, instead of changing only the single bit needed to enable
bitmap mode. This means calling it resets the vertical fine-scroll value
to a fixed default and clears the raster-compare high bit, regardless of
anything you've set up before. If you call `ScrollY` or arm a raster
interrupt on a line at or past 256, do it *after* calling
`SetBitmapMode`, not before, or that setup gets silently undone.
