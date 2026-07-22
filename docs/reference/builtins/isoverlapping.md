# `IsOverlapping`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Checks whether two points are within a given distance of each other on
both axes independently, a quick square proximity/collision test rather
than a true circular (Euclidean) distance check. Returns `1` if both the
horizontal and vertical gap between the two points are within `dist`,
`0` otherwise.

## Syntax

    <byte> := IsOverlapping( <x1>, <y1>, <x2>, <y2>, <dist> )

## Parameters

- `<x1>`, `<y1>`: coordinates of the first point.
- `<x2>`, `<y2>`: coordinates of the second point.
- `<dist>`: the maximum allowed gap, checked separately on the X axis and
  the Y axis.

## Returns

`1` if `abs(x1-x2) <= dist` and `abs(y1-y2) <= dist`, `0` otherwise.

## Example

```pascal
program IsOverlappingDemo;
var
	result : byte;
begin
	clearscreen(key_space,screen_char_loc);

	// (10,10) and (12,11) are within 4 units on both axes: overlap
	result := IsOverlapping(10,10, 12,11, 4);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,3);

	// (10,10) and (50,50) are far apart: no overlap
	result := IsOverlapping(10,10, 50,50, 4);
	moveto(0,1,hi(screen_char_loc));
	printdecimal(result,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/isoverlapping.ras){ .md-button download }
