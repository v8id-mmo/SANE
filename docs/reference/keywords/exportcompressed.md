# `@exportcompressed`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports a charset-family `.flf` image/asset as
a compressed screen/charset/colour triplet: three separate output files
for the screen (character index) data, the charset (bitmap) data, and the
colour data. See [`@export`](export.md) for what `.flf` is and where it
comes from.

## Syntax

    @exportcompressed "<input .flf file>" "<output file>" <x> <y> <w> <h> <compression>;

## Parameters

- `<input .flf file>`: path to a charset-family `.flf` asset (charmap,
  sprite sheet, or similar). Compilation fails with an error if it doesn't
  exist.
- `<output file>`: base name; the compiler appends `_screen.bin`,
  `_charset.bin`, and `_color.bin` to it for the three actual output files.
- `<x>`, `<y>`, `<w>`, `<h>`: region of the source image to export.
- `<compression>`: compression mode passed through to the underlying
  charset compressor; `0` for the default.

## Example

```pascal
program ExportCompressedDemo;

@exportcompressed "sample_sprite.flf" "sample_sprite_compressed.bin" 0 0 8 8 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportcompressed.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
