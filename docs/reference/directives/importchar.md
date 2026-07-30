# `@importchar`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE silently writes the output file back unchanged when it isn't the
one asset type this step actually supports; SANE fails with a clear
compile error instead.

A build-time directive intended to copy a single character/tile from one
image asset into another, at a given position in each. See
[`@export`](export.md) for what `.flf` is and where it comes from.

## Syntax

    @importchar "<input file>" "<output .flf file>" <srcChar> <dstChar>;

## Parameters

- `<input file>`: path to the source data to copy a character from. Either
  a raw binary file (`.bin`/`.chr`) or another `.flf` asset.
- `<output .flf file>`: path to an existing `.flf` asset to copy into.
  Compilation fails with an error if it doesn't already exist; unlike
  `@bin2inc`, this directive edits an existing asset in place rather than
  creating one from scratch.
- `<srcChar>`: index of the character to read from the input.
- `<dstChar>`: index of the character slot to write into, in the output
  asset.

**No example is shown on this page.** The one asset type this directive's
copy step actually supports (see Known limitations below) isn't
producible from within this CLI-only fork, and every `.flf` asset bundled
in this repo is a different, unsupported type; a broken example is worse
than none, so none is included here.

## Known limitations

**The actual character-copy step is unimplemented for every asset type
this fork can produce, so in vanilla TRSE `@importchar` compiles without
error but never changes the output file.** Both the input and output
files are loaded successfully, but the step that's supposed to copy one
character's data across falls back to a do-nothing default for every
reachable C64 asset type (charset, sprite, multicolor bitmap,
full-screen character, etc.). Only one unrelated, non-C64 asset type
(NES) actually implements it. The output `.flf` file is saved back to
disk byte-for-byte identical to how it started.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
this directive still only works for that one non-C64 asset type; nothing
new is now supported. What changed is the failure mode: pointing
`@importchar` at any other destination asset type (every `.flf` bundled
in this repository included) now stops compilation with a clear error,
instead of silently saving the output file back unchanged.
