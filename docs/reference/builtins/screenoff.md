# `ScreenOff`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Blanks the VIC-II display by clearing the screen's display-enable bit.
The CPU keeps running exactly as before (interrupts, screen memory
writes, everything), only the picture itself goes blank; this also frees
up the raster cycles the VIC-II would otherwise spend on "bad lines",
useful right before a section of code that needs every available cycle.
[`ScreenOn`](screenon.md) turns the display back on.

## Syntax

    ScreenOff()

## Example

```pascal
program ScreenOffDemo;
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("screen off in...",0,40);

	Wait(50);
	screenoff(); // blanks the display, VIC-II badlines stop, more raster time available

	Wait(50);
	screenon();
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/screenoff.ras){ .md-button download }
