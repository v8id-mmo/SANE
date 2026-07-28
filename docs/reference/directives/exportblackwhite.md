# `@exportblackwhite`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
silently writes an empty output file when the loaded asset isn't the one
type this directive actually supports; SANE fails with a clear compile
error instead.

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

**No example is shown on this page.** The one asset type this directive
actually supports isn't producible from within this CLI-only fork (see
Known limitations below), and every `.flf` asset bundled in this repo is
a different, unsupported type; a broken example is worse than none, so
none is included here.

## Known limitations

**Only works for one specific `.flf` asset type.** Black & white export is
only actually implemented for a "plain bitmap loaded from an ordinary
image file" asset. In vanilla TRSE, every other asset type (charset,
sprite, multicolor bitmap, level, etc.) falls back to a do-nothing default
that silently produces a zero-byte output file, with no warning or error.

Worse, that one working asset type appears to be effectively unreachable
in this fork already: it corresponds to an image imported directly from a
plain bitmap file (PNG etc.) through TRSE's GUI image-import dialog, part
of the GUI IDE this fork has removed. None of the `.flf` files bundled
anywhere in this repository are of that type, so there is currently no
known way, from within this CLI-only fork, to produce an asset
`@exportblackwhite` actually does anything with.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
this directive still only works for that one asset type; nothing new is
now supported. What changed is the failure mode: pointing
`@exportblackwhite` at any other asset type (including every `.flf`
bundled in this repository) now stops compilation with a clear error
naming the input file, instead of silently writing an empty output file
with no warning.
