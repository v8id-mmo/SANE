# `@vbmexport`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports a linear run of characters from an
image asset as raw bitmap pixel data, 8 bytes per character. Related to
[`@vbmexportchunk`](vbmexportchunk.md) (a rectangular region instead of a
linear run) and [`@vbmexportcolor`](vbmexportcolor.md) (the matching color
data).

## Syntax

    @vbmexport "<input file>" "<output file>" <start> <end> <height> <is multicolor>;

## Parameters

- `<input file>`: path to the source image asset (an `.flf` file).
- `<output file>`: path to write the raw binary export to.
- `<start>`, `<end>`: the range of characters (by index into the asset's
  character grid) to export.
- `<height>`: how many character rows tall each entry in the range is
  treated as, for wrapping to the next row of the grid.
- `<is multicolor>`: `1` if the source asset uses multicolor mode
  (affects how each character's pixel data is interpreted), `0`
  otherwise.

## Example

```pascal
program VbmExportDemo;

@vbmexport "sample_sprite.flf" "sample_sprite_vbm.bin" 0 4 8 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/vbmexport.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
