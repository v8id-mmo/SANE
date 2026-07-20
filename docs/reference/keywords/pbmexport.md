# `@pbmexport`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that converts a bitmap graphic into "PET Bitmap
Mode" (PBM) data: 16 PETSCII characters representing 2x2 pixel blocks,
giving a blocky double-resolution look on text-mode-only machines like the
PET, while still working on C64/VIC-20/etc. See [`@export`](export.md) for
what `.flf` is and where it comes from.

## Syntax

    @pbmexport "<input .flf file>" "<output file>" <start> <width> <height> <exportType>;

## Parameters

- `<input .flf file>`: path to the `.flf` asset to export. Compilation
  fails with an error if it doesn't exist.
- `<output file>`: path to write the raw binary export to.
- `<start>`: index of the first character/tile to export.
- `<width>`, `<height>`: how many characters/tiles to export, in each
  direction.
- `<exportType>`: output format variant. `0` writes literal PETSCII
  screencodes; other values pack the same 2x2 block pattern more compactly
  for use as raw graphics data instead of on-screen characters.

## Example

```pascal
program PbmExportDemo;

@pbmexport "sample_sprite.flf" "sample_sprite_pbm.bin" 0 8 8 1

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pbmexport.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
