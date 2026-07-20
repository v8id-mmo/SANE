# Keywords

One reference page per language keyword. The full list (103 keywords,
scoped to the C64 target) is tracked in `DOCS_PROGRESS.md`'s "Keywords"
checklist; pages are written in small batches, verified against the
compiler source, so this list grows over several sessions rather than all
at once.

## Written so far

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
