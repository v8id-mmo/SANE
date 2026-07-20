# `@vbmexportcolor`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports the per-character color values from a
region of an image asset, one byte per character, instead of the pixel
bitmap data itself. Meant to pair with [`@vbmexport`](vbmexport.md)/
[`@vbmexportchunk`](vbmexportchunk.md), which export the bitmap side.

## Syntax

    @vbmexportcolor "<input file>" "<output file>" <start> <width> <height> <line height>;

## Parameters

- `<input file>`: path to the source image asset (an `.flf` file).
- `<output file>`: path to write the raw binary export to.
- `<start>`: index into the image's character grid to start reading from.
- `<width>`, `<height>`: size, in characters, of the region to read.
- `<line height>`: only one color byte is written per this many rows (set
  to `1` to get a color byte for every row; a larger value skips rows,
  useful for multicolor/hires modes where color only changes once per
  several pixel rows).

## Example

```pascal
program VbmExportColorDemo;

@vbmexportcolor "sample_sprite.flf" "sample_sprite_vbmcolor.bin" 0 4 4 8

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/vbmexportcolor.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
