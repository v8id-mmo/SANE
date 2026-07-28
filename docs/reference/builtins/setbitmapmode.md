# `SetBitmapMode`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
overwrote the whole VIC-II control register with a fixed value; SANE does
a masked read-modify-write that only changes the bitmap-mode bit.

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

**In vanilla TRSE, `SetBitmapMode` overwrites the entire VIC-II control
register with one fixed value, instead of changing only the single bit
needed to enable bitmap mode.** This means calling it on vanilla TRSE
resets the vertical fine-scroll value to a fixed default and clears the
raster-compare high bit, regardless of anything you've set up before. On
vanilla TRSE, if you call `ScrollY` or arm a raster interrupt on a line
at or past 256, do it *after* calling `SetBitmapMode`, not before, or
that setup gets silently undone.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`SetBitmapMode` now only changes the single bit needed to enable bitmap
mode, the same masked read-modify-write shape as its sibling mode-toggle
builtins (`SetTextMode`, `SetMultiColorMode`, `SetRegularColorMode`), so
a vertical fine-scroll value set with [`ScrollY`](scrolly.md), or a
raster interrupt armed on a line at or past 256, now survives a call to
`SetBitmapMode` regardless of ordering.
