# `Jammer`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A raster-timing watchdog, meant to be dropped into time-critical code
(typically inside a raster interrupt) right after a section with a known
timing budget. It compares the given target raster line against the
current one: if the beam hasn't reached it yet, execution falls through
normally. If the beam has already passed it, meaning the preceding code
overran its budget, the machine freezes on the spot and the border and
background are set to the given color, as a visible "you're late" alarm
in the emulator or on real hardware.

## Syntax

    Jammer( <targetRasterLine>, <color> )

## Parameters

- `<targetRasterLine>`: the raster line the beam is expected to not have
  reached yet at this point in the code.
- `<color>`: the border/background color to freeze on if the check fails.

## Example

```pascal
program JammerDemo;
var
	msg : cstring = "WATCHDOG OK";
begin
	clearscreen(key_space,screen_char_loc);
	// If the raster beam has not yet reached line 250 at this point in the
	// frame, execution falls through here silently. If it has, Jammer
	// freezes the machine and paints the border/background red instead,
	// so a real caller would place this right after code with a known
	// raster-timing budget.
	Jammer(250,red);
	moveto(0,0,hi(screen_char_loc));
	printstring(msg,0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/jammer.ras){ .md-button download }
