# `@exportblackwhite`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive intended to export a `.flf` image/asset as
1-bit-per-pixel black & white data. See [`@export`](export.md) for what
`.flf` is and where it comes from.

## Syntax

    @exportblackwhite "<input .flf file>" "<output file>" <x> <y> <w> <h>;
    @exportblackwhite "<input .flf file>" "<output file>" <x> <y> <w> <h> <type>;

## Parameters

- `<input .flf file>`: path to the `.flf` asset to export. Compilation
  fails with an error if it doesn't exist.
- `<output file>`: path to write the raw binary export to.
- `<x>`, `<y>`, `<w>`, `<h>`: region of the source image to export.
- `<type>` (optional): export format variant. Defaults to `0`.

## Example

```pascal
program ExportBlackWhiteDemo;

@exportblackwhite "sample_sprite.flf" "sample_sprite_bw.bin" 0 0 8 8

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportblackwhite.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)

## Known limitations

**Only works for one specific `.flf` asset type, and silently produces an
empty output file (no error) for every other type.** Black & white export
is only actually implemented for a "plain bitmap loaded from an ordinary
image file" asset. Every other asset type (charset, sprite, multicolor
bitmap, level, etc.) falls back to a do-nothing default that produces a
zero-byte output file with no warning or error.

Worse, that one working asset type appears to be effectively unreachable
in this fork already: it corresponds to an image imported directly from a
plain bitmap file (PNG etc.) through TRSE's GUI image-import dialog, part
of the GUI IDE this fork has removed. None of the `.flf` files bundled
anywhere in this repository are of that type, so there is currently no
known way, from within this CLI-only fork, to produce an asset
`@exportblackwhite` actually does anything with. The example above
compiles cleanly (per this site's rule that every example must compile),
but its output file is empty, since `sample_sprite.flf` is a sprite-type
asset, not the one type this directive supports.
