# `hidebordery`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Toggles the VIC-II's row-select bit, widening (or restoring) the
top/bottom border. Commonly used alongside a raster interrupt to
implement the classic "open border" demo effect. `hideborderx` is the
counterpart for the left/right border.

## Syntax

    hidebordery( <0 or 1> )

## Parameters

- `<0 or 1>`: `1` clears the row-select bit (border hidden); `0` sets it
  back (border restored to normal).

## Example

```pascal
program HideBorderYDemo;
begin
	clearscreen(key_space,screen_char_loc);
	hidebordery(1);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/hidebordery.ras){ .md-button download }
