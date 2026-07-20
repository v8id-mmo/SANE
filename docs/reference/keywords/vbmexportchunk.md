# `@vbmexportchunk`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports a rectangular region of an image
asset as raw bitmap pixel data, 8 bytes per character. The rectangular
counterpart to [`@vbmexport`](vbmexport.md)'s linear range, and the raw-data
counterpart to [`@vbmcompilechunk`](vbmcompilechunk.md), which reads the
same kind of region but writes generated source code instead of raw bytes.

## Syntax

    @vbmexportchunk "<input file>" "<output file>" <start> <width> <height> <is multicolor>;

## Parameters

- `<input file>`: path to the source image asset (an `.flf` file).
- `<output file>`: path to write the raw binary export to.
- `<start>`: index into the image's character grid to start reading from.
- `<width>`, `<height>`: size, in characters, of the region to read.
- `<is multicolor>`: `1` if the source asset uses multicolor mode
  (affects how each character's pixel data is interpreted), `0`
  otherwise.

## Example

```pascal
program VbmExportChunkDemo;

@vbmexportchunk "sample_sprite.flf" "sample_sprite_vbmchunk.bin" 0 4 4 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/vbmexportchunk.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
