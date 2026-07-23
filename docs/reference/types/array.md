# `array`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A fixed-size, zero-indexed sequence of elements sharing one type,
declared with a compile-time-known (or initializer-list-inferred) size.

## Syntax

    name : array[<size>] of <type>;
    name : array[<size>] of <type> = (v1, v2, ...);
    name : array[] of <type> = (v1, v2, ...);   // size inferred from the list

## Parameters

- `<size>`: the element count, a compile-time constant. Can be omitted
  (`array[]`) when an initializer list is given, in which case the size is
  inferred from how many values are listed.
- `<type>`: the shared element type: `byte`, `integer`, `boolean`, a
  `record`/[`class`](class.md) name, or another named type.

## Example

```pascal
program ArrayDemo;
var
	scores : array[5] of byte = (10,20,30,40,50);
	lookup : array[] of byte = (1,1,2,3,5,8,13,21); // size inferred: 8
	i : byte;
	total : integer;
begin
	clearscreen(key_space,screen_char_loc);

	total := 0;
	for i := 0 to 4 do
		total := total + scores[i];

	moveto(0,0,hi(screen_char_loc));
	printstring("sum:",0,40);
	moveto(5,0,hi(screen_char_loc));
	printdecimal(total,3);

	moveto(0,1,hi(screen_char_loc));
	printstring("fib[6]:",0,40);
	moveto(8,1,hi(screen_char_loc));
	printdecimal(lookup[6],2);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/array.ras){ .md-button download }

## Known limitations

Three restrictions worth knowing up front, all clean compile errors rather
than silently wrong behavior:

- **Arrays can't be nested directly**: `array[N] of array[M] of byte` is
  rejected. See [`of`](../keywords/of.md)'s Known limitations for the
  workaround (a flat array with manual `row*width + col` indexing, or a
  record wrapping an array).
- **An array of `record` can't use a record type that itself contains an
  array field**: `array[N] of SomeRecord` fails to compile if `SomeRecord`
  has an array member, with an explicit error naming the record type.
  This restriction is specific to `record`; a [`class`](class.md) with an
  array field can be used as an array element type without triggering it.
- **Whole-array assignment (`b := a;` for two same-shaped arrays) isn't
  supported**: it fails to compile with a message suggesting `#a` (taking
  its address) instead. Copy element-by-element in a loop, or use
  [`MemCpy`](../builtins/memcpy.md)/[`BlockMemCpy`](../builtins/blockmemcpy.md)
  for a raw byte-range copy.
