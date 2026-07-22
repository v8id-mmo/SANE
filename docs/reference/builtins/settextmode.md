# `SetTextMode`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Switches the VIC-II from bitmap mode back into character (text) mode,
the opposite of [`SetBitmapMode`](setbitmapmode.md).

## Syntax

    SetTextMode()

## Example

```pascal
program SetTextModeDemo;
begin
	SetBitmapMode();
	Wait(100);
	SetTextMode();   // back to character mode
	clearscreen(key_space, screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("back in text mode",0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/settextmode.ras){ .md-button download }
