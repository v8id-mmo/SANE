# Directives

Directives are the `@`-prefixed build-time instructions: file/asset
import-export, compile-time conditionals, and project configuration.
Unlike plain [keywords](../keywords/index.md), a directive doesn't
generate runtime code by itself, it controls something about the build
itself (an asset conversion, a file operation, a conditional-compile
check, and so on).

- [`@addcpmheader`](addcpmheader.md): prepends a 2-byte CP/M-style length
  header to a binary file.
- [`@addemulatorparam`](addemulatorparam.md): adds a custom launch
  parameter for the emulator.
- [`@addmonitorcommand`](addmonitorcommand.md): runs a VICE monitor
  command automatically once the program loads.
- [`@bin2inc`](bin2inc.md): converts a binary file into an includable
  byte-array source file.
- [`@compress`](compress.md): LZ4-compresses a file on disk via an
  external `lz4` tool.
- [`@copyfile`](copyfile.md): copies a file within the project directory
  at build time.
- [`@define`](define.md): defines a compile-time text substitution
  (`@name` becomes its value).
- [`@deletefile`](deletefile.md): deletes a file within the project
  directory at build time, if it exists.
- [`@donotprefix`](donotprefix.md): meant to exempt one symbol from
  unit-name prefixing; currently broken, see its Known limitations.
- [`@donotprefixunit`](donotprefixunit.md): disables unit-name prefixing
  for an entire unit file.
- [`@donotremove`](donotremove.md): protects a symbol from the unused-
  symbol removal pass.
- [`@endassembler`](endassembler.md): appends raw text to the end of the
  generated assembly output.
- [`@endblock`](endblock.md): closes a fixed-address memory region opened
  by `@startblock`.
- [`@endif`](endif.md): closes an `@ifdef`/`@ifndef` conditional-
  compilation block.
- [`@endmacro`](endmacro.md): closes a `@macro` block (a JavaScript,
  compile-time TRSE source generator).
- [`@error`](error.md): aborts compilation immediately with a custom error
  message.
- [`@execute`](execute.md): runs an external command-line program at build
  time and waits for it to finish.
- [`@export`](export.md): exports a `.flf` image/asset to a raw binary
  file.
- [`@export_parallax_data`](export_parallax_data.md): generates pre-shifted
  charset/screen data for a scrolling parallax layer.
- [`@exportblackwhite`](exportblackwhite.md): exports a `.flf` image/asset
  as 1-bit-per-pixel black & white data.
- [`@exportcompressed`](exportcompressed.md): exports a charset-family
  `.flf` asset as a screen/charset/colour triplet.
- [`@exportframe`](exportframe.md): exports one or more frames/levels from
  a `.flf` asset.
- [`@exportprg2bin`](exportprg2bin.md): extracts a byte range from an
  existing compiled `.prg` file into a raw binary slice.
- [`@exportrgb8palette`](exportrgb8palette.md): exports a `.flf` image/
  asset's colour palette as raw RGB data.
- [`@exportsubregion`](exportsubregion.md): exports a rectangular region of
  a `.flf` image/asset to a raw binary file.
- [`@if`](if.md): compiles a block only if a symbol was `@define`d as a
  specific value.
- [`@ifdef`](ifdef.md): compiles a block only if a symbol was `@define`d.
- [`@ifndef`](ifndef.md): compiles a block only if a symbol was **not**
  `@define`d.
- [`@ignoremethod`](ignoremethod.md): excludes a builtin from automatic
  initialization.
- [`@ignoresystemheaders`](ignoresystemheaders.md): intended to suppress
  automatic system header content (currently has no effect).
- [`@importchar`](importchar.md): copies a single character/tile from one
  image asset into another.
- [`@include`](include.md): splices the contents of another file directly
  into the source.
- [`@macro`](macro.md): defines a JavaScript-based, compile-time TRSE
  source generator.
- [`@pathtool`](pathtool.md): meant to sample a fitted curve into position
  data files; currently broken, see its Known limitations.
- [`@pbmexport`](pbmexport.md): converts a bitmap graphic into PET Bitmap
  Mode block data.
- [`@perlinnoise`](perlinnoise.md): fills a binary file with 2D coherent
  noise data.
- [`@projectsettings`](projectsettings.md): overrides a project setting
  from within source code.
- [`@raiseerror`](raiseerror.md): aborts compilation immediately with a
  custom error message.
- [`@raisewarning`](raisewarning.md): emits a custom compile-time warning
  without stopping compilation.
- [`@requirefile`](requirefile.md): aborts compilation with a custom
  message if a required file doesn't exist.
- [`@setcompressionweights`](setcompressionweights.md): tunes the
  similarity check `@exportcompressed` uses to merge near-identical
  characters.
- [`@setvalue`](setvalue.md): sets a raw project/settings configuration
  key directly by name.
- [`@sparklefile`](sparklefile.md): embeds a Sparkle 3 disk-authoring
  script for building a D64 image.
- [`@splitfile`](splitfile.md): splits a binary file into two files at a
  given byte offset.
- [`@spritecompiler`](spritecompiler.md): intended to generate
  sprite-drawing code from an image region; produces no output on this
  fork's target.
- [`@spritepacker`](spritepacker.md): packs an image into a Game Boy or
  SNES sprite format; not usable for C64.
- [`@startassembler`](startassembler.md): prepends a raw line of text to
  the start of the generated assembly source.
- [`@startblock`](startblock.md): pins declarations/code between it and
  `@endblock` to a fixed memory address.
- [`@use`](use.md): pulls a unit's procedures, functions, and variables
  into the current compile.
- [`@userdata`](userdata.md): reserves a fixed memory range so the
  compiler's allocator never touches it.
- [`@vbmcompilechunk`](vbmcompilechunk.md): generates self-drawing
  procedures from a region of an image asset.
- [`@vbmexport`](vbmexport.md): exports a linear run of characters from an
  image asset as raw bitmap data.
- [`@vbmexportchunk`](vbmexportchunk.md): exports a rectangular region of
  an image asset as raw bitmap data.
- [`@vbmexportcolor`](vbmexportcolor.md): exports the per-character color
  data from a region of an image asset.
