# `WaitForVerticalBlank`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Busy-waits for one full vertical blank (the start of a new frame). A
simple way to pace a main loop to the screen's own refresh rate without
setting up a raster interrupt.

## Syntax

    WaitForVerticalBlank();

Takes no parameters.

## Example

```pascal
program WaitForVerticalBlankDemo;
var
	frame : byte = 0;
begin
	clearscreen(key_space,screen_char_loc);
	while (true) do
	begin
		waitforverticalblank(); // sync to the screen's refresh rate
		frame := frame + 1;
		moveto(0,0,hi(screen_char_loc));
		printdecimal(frame,3);
	end;
end.
```

[:material-download: Download this example](../../assets/examples/waitforverticalblank.ras){ .md-button download }
