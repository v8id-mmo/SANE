# `sizeof`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Returns the size of a variable in bytes, as a compile-time constant. It
doesn't run any code: the value is worked out entirely from the
variable's own declaration (or, for an `incbin` variable, from the size
of the file that was actually loaded).

`sizeof` always counts raw bytes. This is different from
[`length`](length.md), which counts elements: for an `array[10] of
integer`, `length()` reports `10` (ten elements) while `sizeof()` reports
`20` (twenty bytes, since each `integer` is two bytes).

## Syntax

    sizeof(<variable>)

## Parameters

- `<variable>`: the variable to measure. Must be an actual declared
  variable (or record), not an arbitrary expression, since the size is
  looked up from its declaration rather than computed at runtime.

## Returns

The variable's size in bytes.

## Example

```pascal
program SizeofDemo;
var
	scores : array[10] of integer;
	byteSize : integer;

begin
	byteSize := sizeof(scores);
	screen_bg_col := lo(byteSize);
	loop();
end.
```

`byteSize` ends up holding `20`: ten `integer` elements at two bytes each.

[:material-download: Download this example](../../assets/examples/sizeof.ras){ .md-button download }
