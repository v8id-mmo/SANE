# Keywords

- [`absolute`](absolute.md): places a variable at a fixed memory address
  (a synonym for `at`).
- [`@addcpmheader`](addcpmheader.md): prepends a 2-byte CP/M-style length
  header to a binary file.
- [`@addemulatorparam`](addemulatorparam.md): adds a custom launch
  parameter for the emulator.
- [`@addmonitorcommand`](addmonitorcommand.md): runs a VICE monitor
  command automatically once the program loads.
- [`asm`](asm.md): inserts raw 6502 assembler directly into the program.
- [`assembler`](assembler.md): marks a whole procedure body as
  hand-written assembler, no `begin`/`end` needed.
- [`at`](at.md): places a variable at a fixed memory address, such as a
  hardware register.
- [`begin`](begin.md): marks the start of a Pascal-style statement block.
- [`@bin2inc`](bin2inc.md): converts a binary file into an includable
  byte-array source file.
- [`break`](break.md): exits the innermost enclosing loop immediately.
- [`buildsinetable`](buildsinetable.md): fills an array at compile time
  with one cycle of a sine wave.
- [`buildtable`](buildtable.md): fills an array at compile time from a
  JavaScript expression evaluated per index.
- [`buildtable2d`](buildtable2d.md): the two-dimensional version of
  `buildtable`, over a width by height grid.
- [`case`](case.md): a multi-way branch on a single value, Pascal-style.
- [`@compress`](compress.md): LZ4-compresses a file on disk via an
  external `lz4` tool.
- [`compressed`](compressed.md): compresses an array/string's initializer
  data at compile time.
- [`const`](const.md): declares a named, compile-time constant.
- [`continue`](continue.md): skips straight to the next loop iteration.
- [`@copyfile`](copyfile.md): copies a file within the project directory
  at build time.
- [`@define`](define.md): defines a compile-time text substitution
  (`@name` becomes its value).
- [`@deletefile`](deletefile.md): deletes a file within the project
  directory at build time, if it exists.
- [`do`](do.md): separates a `for`/`while` loop's header from its body.
- [`@donotprefix`](donotprefix.md): meant to exempt one symbol from
  unit-name prefixing; currently broken, see its Known limitations.
- [`@donotprefixunit`](donotprefixunit.md): disables unit-name prefixing
  for an entire unit file.
- [`@donotremove`](donotremove.md): protects a symbol from the unused-
  symbol removal pass.
- [`else`](else.md): the optional branch of `if`/`then` (or `case`) that
  runs when the condition is false.
- [`end`](end.md): closes a block opened by `begin`, or a `case`
  statement.
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
- [`for`](for.md): a counted loop from a start value up to (but not
  including) an end value.
- [`fori`](fori.md): the inclusive counted loop, up to and including the
  end value.
- [`forward`](forward.md): declares a procedure/function's signature
  before its real body, for forward/mutual references.
- [`function`](function.md): a procedure that returns a value.
- [`global`](global.md): binds a procedure parameter directly to an
  existing global variable, skipping parameter-passing overhead.
- [`if`](if.md): the standard conditional statement.
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
- [`inline`](inline.md): requests that a procedure's code be inserted
  directly at each call site instead of a real call.
- [`interrupt`](interrupt.md): declares a procedure as an interrupt
  handler instead of an ordinary procedure.
- [`invert`](invert.md): sets the high bit on every character of a
  `cstring`, for reverse-video PETSCII text.
- [`krillsloader`](krillsloader.md): sets up Krill's C64 loader, an
  argument to `@use`.
- [`length`](length.md): returns an array's element count (or a string's
  size) as a compile-time constant.
- [`@macro`](macro.md): defines a JavaScript-based, compile-time TRSE
  source generator.
- [`no_term`](no_term.md): suppresses the automatic terminator byte on a
  `string`/`cstring` declaration.
- [`of`](of.md): links an array's bound (or a pointer's) to its element
  type, and separates a `case` expression from its branches.
- [`offpage`](offpage.md): forces a long jump instead of a short branch
  for a conditional's generated code.
- [`onpage`](onpage.md): forces a short relative branch for a
  conditional's generated code, with no size safety check.
- [`@pathtool`](pathtool.md): meant to sample a fitted curve into position
  data files; currently broken, see its Known limitations.
- [`@pbmexport`](pbmexport.md): converts a bitmap graphic into PET Bitmap
  Mode block data.
- [`@perlinnoise`](perlinnoise.md): fills a binary file with 2D coherent
  noise data.
- [`private`](private.md): a class/record visibility keyword with no
  working implementation, see its Known limitations.
- [`procedure`](procedure.md): a named, callable block of statements.
- [`program`](program.md): opens a source file and names the compiled
  program.
- [`@projectsettings`](projectsettings.md): overrides a project setting
  from within source code.
- [`public`](public.md): a class/record visibility keyword with no
  working implementation, see its Known limitations.
- [`@raiseerror`](raiseerror.md): aborts compilation immediately with a
  custom error message.
- [`@raisewarning`](raisewarning.md): emits a custom compile-time warning
  without stopping compilation.
- [`repeat`](repeat.md): a post-condition loop that runs its body at
  least once, paired with `until`.
- [`repend`](repend.md): closes an inline-assembler `repeat N` unrolling
  block.
- [`@requirefile`](requirefile.md): aborts compilation with a custom
  message if a required file doesn't exist.
- [`return`](return.md): exits the current procedure or function
  immediately.
- [`@setcompressionweights`](setcompressionweights.md): tunes the
  similarity check `@exportcompressed` uses to merge near-identical
  characters.
- [`@setvalue`](setvalue.md): sets a raw project/settings configuration
  key directly by name.
- [`signed`](signed.md): marks a numeric variable as holding a signed
  value, see its Known limitations.
- [`sizeof`](sizeof.md): the size of a variable in bytes, as a
  compile-time constant.
- [`@sparklefile`](sparklefile.md): embeds a Sparkle 3 disk-authoring
  script for building a D64 image.
- [`@splitfile`](splitfile.md): splits a binary file into two files at a
  given byte offset.
- [`@spritecompiler`](spritecompiler.md): intended to generate
  sprite-drawing code from an image region; produces no output on this
  fork's target.
- [`@spritepacker`](spritepacker.md): packs an image into a Game Boy or
  SNES sprite format; not usable for C64.
- [`stack`](stack.md): passes a `byte` parameter through the hardware
  stack instead of a fixed address, enabling recursion.
- [`@startassembler`](startassembler.md): prepends a raw line of text to
  the start of the generated assembly source.
- [`@startblock`](startblock.md): pins declarations/code between it and
  `@endblock` to a fixed memory address.
- [`step`](step.md): sets the increment amount for a `for`/`fori` loop
  counter.
- [`then`](then.md): separates an `if` condition from its true branch.
- [`to`](to.md): separates a `for` loop's start value from its end value.
