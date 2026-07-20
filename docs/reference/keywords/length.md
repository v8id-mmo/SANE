# `length`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns the number of elements in an array (or the declared size of a
string), as a compile-time constant. It doesn't run any code: the value is
worked out entirely from the variable's own declaration.

## Syntax

    length(<variable>)

## Parameters

- `<variable>`: the array or string variable to measure. Must be an actual
  declared variable, not an arbitrary expression, since the size is looked
  up from its declaration rather than computed at runtime.

## Returns

The element count. For a `byte` array this is the same as its declared
size; for `integer`/`long`/pointer arrays it's the number of elements, not
the number of underlying bytes (so a `array[10] of integer` reports `10`,
not `20`).

## Example

```pascal
program LengthDemo;
var
	scores : array[10] of byte;
	scoreCount : byte = 0;

begin
	scoreCount := length(scores);
	screen_bg_col := scoreCount;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/length.ras){ .md-button download }
