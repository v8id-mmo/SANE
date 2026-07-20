# `of`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Grammar glue, not a standalone statement. It links a bound (an array size)
or a pointer to the element type that follows it, and it's also the word
that separates a [`case`](case.md) statement's expression from its list of
branches.

## Syntax

    name : array[<size>] of <type> [= (v1, v2, ...)];
    name : array[] of <type> = (v1, v2, ...);   // size inferred from the list

    name : pointer of <type>;
    name : lpointer of <type>;

    case <expression> of
      ...
    end;

## Parameters

- `<size>`: the array's element count. Can be omitted (`array[]`) if an
  initializer list is given; the size is then inferred from how many
  values are listed.
- `<type>`: the element type for an array, or the type a pointer refers
  to. Can also be `buildtable(...)`, [`buildsinetable`](buildsinetable.md)`(...)`,
  or [`buildtable2d`](buildtable2d.md)`(...)` in the array form, to
  auto-generate the initializer at compile time instead of writing one out
  by hand.

## Example

```pascal
program OfDemo;
var
	lookup : array[16] of byte = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
	valuePtr : pointer of byte;
	i : byte;

begin
	valuePtr := #lookup;
	for i := 0 to 15 do
	begin
		screen_bg_col := valuePtr^;
		valuePtr := valuePtr + 1;
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/of.ras){ .md-button download }

## Known limitations

Arrays can't be nested directly: `array[N] of array[M] of byte` is
rejected with a compile error rather than working as a 2D array. Use a
record wrapping an array, or manual index arithmetic (`row*width + col`
into a flat array), for grid-shaped data instead.
