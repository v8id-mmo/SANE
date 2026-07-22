# `hideborderx`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Toggles the VIC-II's column-select bit, widening (or restoring) the
left/right side border. Commonly used alongside a raster interrupt to
implement the classic "open border" demo effect. `hidebordery` is the
counterpart for the top/bottom border.

## Syntax

    hideborderx( <0 or 1> )

## Parameters

- `<0 or 1>`: `1` clears the column-select bit (border hidden); `0` sets
  it back (border restored to normal).

## Example

```pascal
program HideBorderXDemo;
begin
	clearscreen(key_space,screen_char_loc);
	hideborderx(1);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/hideborderx.ras){ .md-button download }
