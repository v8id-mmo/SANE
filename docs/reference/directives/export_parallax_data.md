# `@export_parallax_data`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that generates pre-shifted charset and screen data
for a horizontally-scrolling parallax layer, from a full-screen character
`.flf` image. See [`@export`](export.md) for what `.flf` is and where it
comes from; this directive specifically needs a **full-screen character**
type asset (one with an attached charset), not a plain sprite/bitmap.

It writes two output files: `<output file base>_charset.bin` (the
generated charset data, pre-shifted for smooth scrolling) and
`<output file base>_screens.bin` (the corresponding screen/tile-index
data), where `<output file base>` is `<output file>` with its extension
stripped.

## Syntax

    @export_parallax_data "<input .flf file>" "<output file>" <x0> <y0> <x1> <y1> <weight> <type> <eor>;

## Parameters

- `<input .flf file>`: path to a full-screen-character `.flf` asset (with
  its own attached charset). Compilation fails with an error if it doesn't
  exist.
- `<output file>`: base name for the two generated `_charset.bin`/
  `_screens.bin` files.
- `<x0>`, `<y0>`, `<x1>`, `<y1>`: the region of the source image to use.
- `<weight>`: passed through to the underlying char-compression pass as its
  weight/threshold parameter.
- `<type>`: if non-zero, remaps any "ambiguous" 2-bit colour value to this
  value before packing; `0` leaves the data unmodified.
- `<eor>`: a byte XORed into every generated charset byte; `0` for no
  transform.

## Example

```pascal
program ExportParallaxDataDemo;

@export_parallax_data "sample_scene.flf" "sample_scene_parallax.bin" 0 0 8 8 0 0 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/export_parallax_data.ras){ .md-button download }
(also needs [`sample_scene.flf`](../../assets/examples/sample_scene.flf) in
the same folder)
