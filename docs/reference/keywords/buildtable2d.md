# `buildtable2d`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The two-dimensional version of [`buildtable`](buildtable.md): fills an
array's initializer at compile time by evaluating a JavaScript expression
once per `(i, j)` cell of a `width` by `height` grid, flattened into a
single one-dimensional array (row-major: `j` is the outer loop, `i` the
inner one).

## Syntax

    var
      <name> : array[<width> * <height>] of <type> = buildtable2d(<width>, <height>, "<js expression>");

## Parameters

- `<width>`, `<height>`: the grid dimensions. The resulting array has
  `<width> * <height>` elements.
- `<js expression>`: a JavaScript expression string, evaluated once per
  cell with `i` bound to the column and `j` to the row. Any user-defined
  `const` is available in the expression by name (see [`define`](define.md)
  for the `@name` style constants used in some of the compiler's own
  tutorials, such as `@DWIDTH`).

## Example

```pascal
program BuildTable2DDemo;
var
	// 8x8 table where each cell holds i+j*8
	grid : array[64] of byte = buildtable2d(8, 8, "i+j*8");
	i : byte = 0;

begin
	for i := 0 to 63 do
	begin
		screen_bg_col := grid[i]&15;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/buildtable2d.ras){ .md-button download }
