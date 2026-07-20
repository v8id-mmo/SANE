# `@exportsubregion`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports a rectangular region of a `.flf`
image/asset file to a raw binary file, instead of the whole thing. See
[`@export`](export.md) for what `.flf` is and where it comes from.

## Syntax

    @exportsubregion "<input .flf file>" "<output file>" <x> <y> <w> <h>;
    @exportsubregion "<input .flf file>" "<output file>" <x> <y> <w> <h> <type>;

## Parameters

- `<input .flf file>`: path to the `.flf` asset to export. Compilation
  fails with an error if it doesn't exist.
- `<output file>`: path to write the raw binary export to.
- `<x>`, `<y>`: top-left corner of the region to export, in the asset's own
  units (pixels or characters, depending on asset type).
- `<w>`, `<h>`: width and height of the region.
- `<type>` (optional): export format variant; meaning is asset-type
  specific. Defaults to `0`.

## Example

```pascal
program ExportSubregionDemo;

@exportsubregion "sample_sprite.flf" "sample_sprite_sub.bin" 0 0 8 8

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportsubregion.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
