# `FillFast`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A faster variant of [`Fill`](fill.md), for the case where the fill value
is already a plain numeric/variable expression. Meant to write the same
`count` bytes that `Fill` would, starting at the given address, just with
a tighter loop.

## Syntax

    FillFast( <address>, <value>, <count> );

## Parameters

- `<address>`: a named address, or a `pointer` variable, referenced with
  `#` if it's a plain address.
- `<value>`: the byte value to write. Must be a plain numeric/variable
  expression, not a more complex one.
- `<count>`: how many bytes to write.

## Example

```pascal
program FillFastDemo;
var
	buf : array[10] of byte;

begin
	clearscreen(key_space, #screen_char_loc);
	FillFast(#buf, 65, 5); // intended: fill buf[0..4]; see Known limitations
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/fillfast.ras){ .md-button download }

## Known limitations

`FillFast` writes one byte more than the `count` given: with a count of
5, as in the example above, it actually fills 6 bytes (`buf[0]` through
`buf[5]`), not 5. `Fill` doesn't have this problem: calling it with the
same arguments writes exactly the requested number of bytes. If the
target buffer is exactly `count` bytes long, `FillFast` overwrites one
byte belonging to whatever comes right after it in memory.
