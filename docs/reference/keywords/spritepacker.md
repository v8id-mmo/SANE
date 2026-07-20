# `@spritepacker`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A build-time directive that packs a source image into a platform-specific
sprite/tile format, alongside a separate character-data output. Not
usable on this fork's C64 target; see Known limitations.

## Syntax

    @spritepacker "<input file>" "<output char file>" "<output sprite file>" "<type>" <x> <y> <w> <h> <compression>;

## Parameters

- `<input file>`: path to the source image/character data to pack.
- `<output char file>`: path to write the packed character data to.
- `<output sprite file>`: path to write the packed sprite data to.
- `<type>`: the target hardware format. Only `"gameboy"` and `"snes"` are
  recognized; anything else fails to compile.
- `<x>`, `<y>`, `<w>`, `<h>`: region of the source to pack.
- `<compression>`: a compression level/flag, meaning depends on `<type>`.

## Known limitations

**Not usable for a C64 build: the `<type>` argument only accepts
`"gameboy"` or `"snes"`, and compilation fails immediately with `Unknown
image type : ... For now, only 'gameboy' and 'snes' is supported.` for
any other value**, including any C64 asset type. This isn't a bug so much
as a directive that was written for other target hardware and never
extended to the 6502/C64 family; there is currently no way to use
`@spritepacker` from a project compiling for C64. No working example is
included on this page, since there is no `<type>` value that both
compiles and produces anything meaningful for this fork's only supported
target.
