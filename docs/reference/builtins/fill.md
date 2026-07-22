# `Fill`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Writes the same byte value to a run of consecutive memory locations
(or, given a `pointer`, a run of consecutive offsets from that pointer).
Writes exactly `count` bytes, starting at the given address.

## Syntax

    Fill( <address>, <value>, <count> );

## Parameters

- `<address>`: a named address, or a `pointer` variable, referenced with
  `#` if it's a plain address.
- `<value>`: the byte value to write.
- `<count>`: how many bytes to write.

## Example

```pascal
program FillDemo;
begin
	clearscreen(key_space, #screen_char_loc);
	Fill(#screen_col_loc, light_blue, screen_width); // fills the top row's color RAM
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/fill.ras){ .md-button download }
