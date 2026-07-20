# `@exportrgb8palette`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports a `.flf` image/asset's colour palette
as raw 8-bit-per-channel RGB data (3 bytes per colour). See
[`@export`](export.md) for what `.flf` is and where it comes from.

## Syntax

    @exportrgb8palette "<input .flf file>" "<output file>";

## Parameters

- `<input .flf file>`: path to the `.flf` asset whose palette should be
  exported.
- `<output file>`: path to write the raw RGB palette data to. If it
  already exists, it's overwritten.

## Example

```pascal
program ExportRGB8PaletteDemo;

@exportrgb8palette "sample_sprite.flf" "sample_sprite_palette.bin"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportrgb8palette.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
