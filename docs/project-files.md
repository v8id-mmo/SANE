# Project & Settings Files

Every compile needs two plain-text configuration files alongside the
source: a **project file** (`.trse`, one per project) and a **settings
file** (commonly named `trse.ini`, shared across projects, passed with
`settings=`). This page documents both in detail: what each file is for,
every setting worth knowing about, and how they interact with the
command line and with source-level overrides. See
[Getting Started](getting-started.md) for the shortest path to compiling
a downloaded example; this page is the fuller reference underneath it.

## File format

Both files share the same plain-text format: one `key = value` pair per
line.

- A value that parses as a plain number is stored as a number (used with
  `getdouble`-style reads internally); anything else is stored as text.
- A list of several values is written with a leading comma, e.g.
  `zeropages = ,$02, $04, $08`; the leading comma is required and is
  discarded when the list is read back, everything after it is the
  actual list of items.
- Key names are always matched in lowercase with surrounding whitespace
  trimmed. Writing a key in a different case, or with a typo, doesn't
  raise an error: the lookup just silently misses and reads back as an
  empty string or `0`, identical to the key not being present at all.
  This is worth remembering when troubleshooting a setting that seems to
  have no effect; see [Known limitations](#known-limitations) below for
  several real examples of exactly this happening in the shipped project
  templates.

## The `.trse` project file

Passed with `project=<file>.trse` on the command line. Holds everything
specific to one project: which target system, memory layout, build
output type, and per-project optimizer/compression toggles.

### Target system

- `system`: must be `C64` (case-insensitive). This fork only implements
  a C64 target; any other value fails during compilation rather than
  producing a clear "unsupported system" error, so it's not a safe way
  to test what happens with a different platform.

### Source file selection

- `main_ras_file`, `open_files`, `current_file`: none of these three
  keys have any effect on a CLI compile. The source file to compile
  always comes from the command line's own `input_file=` argument, never
  from anything inside the project file.

### Build output

- `output_type`: `prg` for a plain C64 program (the common case), `crt`
  for a cartridge image, or `d64` for a disk image.
- `output_debug_symbols`: when enabled, also writes a `.sym` symbol file
  alongside the compiled program (for use with an emulator's monitor,
  e.g. VICE's `.sym` support).
- `disk_system`, `disk1_type`, `use_track_19`: only relevant when
  `output_type = d64`; select an alternate disk fastloader system and
  low-level disk layout options.

### Zero-page allocation

`zeropages`, `temp_zeropages`, `zeropages_userdefined`,
`zeropage_internal1`-`4`, `zeropage_decrunch1`-`4`,
`zeropage_screenmemory`, `zeropage_colormemory`: carve up the C64's zero
page between the compiler's own bookkeeping and space reserved for a
program's own inline assembly. See
[Platform Notes' Zero page usage section](platform-notes.md#zero-page-usage)
for what each one controls and which builtins depend on them being
populated.

### Optimizer settings

- `remove_unused_symbols`: after parsing, drops any variable or
  procedure nothing in the program actually reads, calls, or references
  (including from inline assembly).
- `post_optimizer_passlda`, `post_optimizer_passjmp`,
  `post_optimizer_passldatax`, `post_optimizer_passstalda`,
  `post_optimizer_passldx`, `post_optimizer_passcmp`,
  `post_optimizer_passphapla`: individually toggle specific peephole
  optimization passes over the generated assembly. See
  [Platform Notes' Build-time optimization settings section](platform-notes.md#build-time-optimization-settings)
  for what each pass collapses. These only take effect at all if the
  settings file's own `post_optimize` master switch (below) is on.

### Compression

- `exomizer_toggle`: turns on whole-program, self-extracting Exomizer
  compression of the finished output. See
  [Platform Notes' Compression section](platform-notes.md#compression-three-unrelated-mechanisms)
  for how this relates to the separate `compressed`/`@compress`/`Decrunch`
  mechanisms. See [Known limitations](#known-limitations) below: several
  shipped project templates spell this key wrong.

### Load address and header overrides

- `override_target_settings`: master switch; the four settings below
  only take effect when this is `1`.
- `override_target_settings_org`: a custom program load address, in
  place of the system default.
- `override_target_settings_basic`: a custom start address for the
  small BASIC stub that normally precedes a C64 program.
- `override_target_settings_sys`: when enabled, skips the automatic
  BASIC `SYS` line entirely.
- `override_target_settings_prg`: when enabled, strips the two-byte
  load-address header a `.prg` file normally starts with.

See [Known limitations](#known-limitations) below: two of these four
keys are spelled differently in most shipped project templates than
what the compiler actually reads, so they don't take effect there.

### Cartridge header fields

Only read when `output_type = crt`:

- `machine_state`, `border_color`, `background_color`: written directly
  into fixed fields of the cartridge header. They have no effect on a
  plain `.prg` build.

### Miscellaneous

- `pascal_settings_use_local_variables`: changes how the parser scopes
  variables declared inside a procedure/function body.
- `project_path`: base directory used to resolve relative
  `@include`/`@use`/asset paths.
- `disable_compiler_comments`: strips the source-line comments the
  compiler normally adds to the generated `.asm` for readability.
- `global_defines`: a list of preprocessor defines applied to the whole
  project, equivalent to repeating [`@define`](reference/directives/define.md)
  for each one in every source file.
- `ignore_initial_jump`: omits the leading unconditional jump the
  generated assembly otherwise starts with.

## The settings file (`trse.ini`, passed as `settings=`)

Shared across every project, rather than specific to one, and passed
once on the command line with `settings=<file>.ini`. A real-world
`trse.ini` you might inherit or copy is mostly a leftover from this
fork's now-removed GUI/IDE: font sizes, editor color themes, a "recent
projects" list, and a path setting for every emulator of every platform
the original project once targeted. None of that has any effect on a
CLI compile. Only a handful of keys are actually read:

- `assembler`: `OrgAsm` (this fork's own bundled 6502 assembler, the
  shipped default) or `dasm` (shells out to an external DASM binary
  instead).
- `dasm`: path to the external DASM binary; only read when
  `assembler = dasm`.
- `post_optimize`: master on/off switch for the peephole optimizer; see
  [Platform Notes](platform-notes.md#build-time-optimization-settings).
  The project file's own `post_optimizer_pass*` keys only matter when
  this is on.
- `lz4`: path to an external `lz4` command-line tool, needed by
  [`@compress`](reference/directives/compress.md).
- `exomizer`: path to the external Exomizer command-line tool, needed
  for whole-program compression (the project file's `exomizer_toggle`).
- `hide_exomizer_footprint`: suppresses Exomizer's own added
  self-extractor banner text.
- `display_addresses`: when enabled, the generated `.asm` includes the
  original source line number next to each instruction, as a comment.
- `c1541`: path to an external `c1541` tool, used when `output_type = d64`.

Every other key you'll find in a real, inherited `trse.ini` (window
palette, font sizes, editor themes, "recent projects", every
`*_emulator` path, splash screen timing, and so on) is safe to ignore or
delete when hand-writing a minimal settings file of your own; none of it
is read by anything reachable from the CLI. See
[Known limitations](#known-limitations) below for one settings-file key
that looks load-bearing but isn't.

## Command-line usage

The full syntax, from [Getting Started](getting-started.md):

```sh
trse -cli op=project project=<project>.trse input_file=<source>.ras settings=<settings>.ini
```

- `project=` and `input_file=` are always required for `op=project`.
- `settings=` is optional. If it's left out, the CLI instead looks for a
  `trse.ini` in the operating system's own per-user application-data
  folder (the same location the removed GUI used to keep its settings
  in automatically). If that file isn't there either, the compile
  doesn't happen; see [Known limitations](#known-limitations) below for
  what that failure actually reports.
- `assemble=no` compiles to `.asm` only, skipping the assemble-to-`.prg`
  step.
- `output_file=<name>` is meant to rename the produced binary, but see
  [Known limitations](#known-limitations) below: it doesn't currently
  work in this, the normal compile mode.

A separate mode, `op=orgasm`, assembles an already-generated `.asm` file
directly into a `.prg`, with no project or settings file needed at all:

```sh
trse -cli op=orgasm input_file=<file>.asm output_file=<file>.prg
```

Useful if the generated assembly itself needs hand-editing before being
assembled. `output_file=` does work correctly in this mode.

### Overriding a setting from source

Either file's values, for either the project file or the settings file,
can be overridden per-compile from inside a `.ras` file itself:
[`@projectsettings`](reference/directives/projectsettings.md) exposes a
small, curated set of friendly names (`"startaddress"`, `"exomize"`, and
a few others), while [`@setvalue`](reference/directives/setvalue.md) can
set any raw key by its exact name, targeting the settings file instead
of the project file if that exact key already exists there. Either way,
the override only affects that one compile; the file on disk is never
modified.

## Known limitations

A missing settings file doesn't fail the way a compile error does: the
CLI prints an explanation and stops without compiling anything, but
still reports a successful exit code, the same one an actual successful
compile returns. A build script or CI job that only checks the exit
code, rather than reading the output, would see this as a passing build.

`output_file=` only renames the produced file in the standalone
`op=orgasm` assemble mode. In the normal `op=project` compile mode, it's
accepted on the command line but silently has no effect at all; the
output keeps the source file's own base name regardless of what
`output_file=` was set to.

Every general-purpose C64 project template this fork ships (including
the downloadable project bundle used to compile the examples on this
site) spells two of its own settings differently than what the compiler
actually reads, so setting them by hand has no effect: `exomize_toggle`
instead of the real key, `exomizer_toggle`, and
`override_target_settings_ignore_sys`/`override_target_settings_ignore_prg`
instead of the real keys,
`override_target_settings_sys`/`override_target_settings_prg`. With
`override_target_settings` turned on in an affected template, only the
custom load address override actually takes effect; skipping the
automatic `SYS` line and stripping the `.prg` header stay off no matter
what the `_ignore_*` keys say. A few of the more specialized templates
carry the correctly-spelled keys alongside the mismatched ones, so
compression and all four overrides do work there. Setting either value
through [`@projectsettings`](reference/directives/projectsettings.md)
from inside a program's source, rather than hand-editing the project
file, always uses the correct key name and isn't affected by this.

In the settings file, `optimizer_remove_unused_symbols` looks like the
on/off switch for removing unused variables and procedures from a
build, but it's never actually read anywhere. The real switch,
`remove_unused_symbols`, is a project-file key instead, not a
settings-file one (see [Optimizer settings](#optimizer-settings) above).
