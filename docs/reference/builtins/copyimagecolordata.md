# `CopyImageColorData`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
silently treated an out-of-range `<bank>` as bank `0`; SANE raises a
compile error instead.

Unpacks an image asset's combined char/color data (as produced by TRSE's
own image export tools) into screen memory and color RAM for a chosen VIC
bank, and sets the border/background colors from the same data.

## Syntax

    CopyImageColorData( <source>, <bank> );

## Parameters

- `<source>`: the address of the exported image data (2 header color
  bytes, followed by 1024 bytes of character/screen data, followed by
  1024 bytes of color data).
- `<bank>`: which VIC bank the screen data should land in: `1` (`$4000`),
  `2` (`$8000`), or `3` (`$c000`). Must be a literal constant number, not
  a variable. Color RAM is always written to the real C64's fixed
  `$D800`, regardless of `<bank>`.

## Example

```pascal
program CopyImageColorDataDemo;
var
	// in a real project this would be an actual exported image asset (2
	// header color bytes + 1024 bytes char data + 1024 bytes color data);
	// any binary blob compiles here, since CopyImageColorData just reads
	// whatever bytes are at the given address
	image_data : incbin("sample_data.bin");
begin
	copyimagecolordata(#image_data, 1);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/copyimagecolordata.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)

## Known limitations

`<bank>` is only meaningful as `1`, `2`, or `3`. In vanilla TRSE, passing
any other value (`0`, or `4` and above) compiles and assembles without any
error or warning, but silently produces the exact same addresses as bank
`0` (`$0400`), not an error and not the address that bank number would
suggest.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
an out-of-range `<bank>` now raises a compile error ("bank must be 1, 2,
or 3") instead of silently defaulting to bank 0's address.
