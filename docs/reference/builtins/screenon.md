# `ScreenOn`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Turns the VIC-II display back on after [`ScreenOff`](screenoff.md), by
setting the screen's display-enable bit back to its normal state.

## Syntax

    ScreenOn()

## Example

```pascal
program ScreenOnDemo;
begin
	clearscreen(key_space,screen_char_loc);
	screenoff();

	Wait(50);
	moveto(0,0,hi(screen_char_loc));
	printstring("screen back on",0,40);
	screenon(); // restores the display

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/screenon.ras){ .md-button download }
