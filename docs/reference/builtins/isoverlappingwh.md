# `IsOverlappingWH`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Checks whether two rectangular hitboxes, anchored at `(x1,y1)` and
`(x2,y2)` and sharing one `width`/`height`, overlap. Same idea as
[`IsOverlapping`](isoverlapping.md), but the X and Y checks each use
their own separate distance value (`width` for X, `height` for Y)
instead of one shared `dist`.

## Syntax

    <byte> := IsOverlappingWH( <x1>, <y1>, <x2>, <y2>, <width>, <height> )

## Parameters

- `<x1>`, `<y1>`: position of the first box.
- `<x2>`, `<y2>`: position of the second box.
- `<width>`: the maximum allowed gap on the X axis.
- `<height>`: the maximum allowed gap on the Y axis.

## Returns

`1` if `abs(x1-x2) <= width` and `abs(y1-y2) <= height`, `0` otherwise.

## Example

```pascal
program IsOverlappingWHDemo;
var
	result : byte;
begin
	clearscreen(key_space,screen_char_loc);

	// two 8x8 boxes close enough to overlap
	result := IsOverlappingWH(10,10, 14,12, 8,8);
	moveto(0,0,hi(screen_char_loc));
	printdecimal(result,3);

	// two 8x8 boxes far enough apart to not overlap
	result := IsOverlappingWH(10,10, 60,60, 8,8);
	moveto(0,1,hi(screen_char_loc));
	printdecimal(result,3);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/isoverlappingwh.ras){ .md-button download }
