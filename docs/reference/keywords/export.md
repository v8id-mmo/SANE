# `@export`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports the contents of a `.flf` image/asset
file to a raw binary file, so it can be brought into a program (typically
via `@bin2inc` on the resulting binary, or loaded at runtime from disk).

`.flf` ("FLUFF64") is TRSE's own binary format for pixel art, charsets,
sprites, and level data, not a common format like PNG. It's the format
produced by TRSE's built-in image/charset/sprite/level editor. **That
editor is part of the GUI IDE, which doesn't exist in this CLI-only fork**,
so no new `.flf` file can currently be created or edited from within this
project; only pre-existing `.flf` assets (such as the ones bundled with the
project templates) can be used as input to `@export` and the rest of the
`@export*` directive family.

## Syntax

    @export "<input .flf file>" "<output file>" <param1>;
    @export "<input .flf file>" "<output file>" <param1> <param2>;

## Parameters

- `<input .flf file>`: path to the `.flf` asset to export. Compilation
  fails with an error if it doesn't exist.
- `<output file>`: path to write the raw binary export to.
- `<param1>` / `<param2>` (second is optional): meaning depends on the
  asset type. For charset-family and NES/SNES assets, a single param is
  taken as an end index and a pair as a start/end range (e.g. which
  characters/tiles to include); for most other asset types they're unused.

## Example

```pascal
program ExportDemo;

@export "sample_sprite.flf" "sample_sprite_export.bin" 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/export.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)
