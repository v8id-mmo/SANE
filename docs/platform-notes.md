# Platform Notes

Practical, C64/6502-specific background that doesn't belong on any single
keyword or builtin page: how the compiler's project settings map onto
real hardware registers, how its zero-page scratch space is allocated,
how its three unrelated compression mechanisms fit together, and what
each generated/edited file actually is. Read this alongside the
[reference](reference/keywords/index.md) section, not instead of it; the
cross-links below point at the exact builtin/keyword page for full
syntax and any known limitation.

## RAM/ROM banking (the `$01` CPU port)

The C64's 6510 CPU has three RAM/ROM banking lines wired to its own I/O
port at `$01` (BASIC ROM, KERNAL ROM, and the I/O/character-ROM area at
`$D000`-`$DFFF` can each be swapped out for plain RAM independently).
[`SetMemoryConfig`](reference/builtins/setmemoryconfig.md) is the
builtin that writes this port; it does a masked read-modify-write, only
touching the banking bits and leaving the rest of the port's contents
(used for the datasette lines, among other things) untouched. See that
page for the exact parameter meaning, and its Known limitations section
for a specific argument combination that doesn't write quite the byte
you'd expect (harmless in practice, but worth knowing if you read the
port back yourself).

[`EnableAllRam`](reference/builtins/enableallram.md) is the coarser,
one-call version: it banks out BASIC and KERNAL ROM, but leaves the I/O
area and color RAM visible, contrary to what the name alone suggests.

## VIC-II bank switching

The VIC-II chip can only see one 16KB quarter of the C64's 64KB address
space at a time for its own screen/charset/sprite/bitmap data, selected
by two bits in a CIA#2 register at `$DD00`.
[`SetBank`](reference/builtins/setbank.md) writes that selection, using
the shipped `VIC_BANK0`-`VIC_BANK3` constants (see
[Constants](reference/constants.md)). The C64 wires those two bits with
inverted logic, so `VIC_BANK0` (bank `$0000`-`$3FFF`) is the constant
value `3`, not `0`; use the named constants rather than raw numbers so
this doesn't have to be remembered. `SetBank`'s Known limitations note
covers the register's other bits, which are shared with the serial
(IEC) bus and RS-232 lines.

Bank selection and *location within the selected bank* are two separate
settings, easy to conflate. Once [`SetBank`](reference/builtins/setbank.md)
has picked the 16KB window, [`SetCharsetLocation`](reference/builtins/setcharsetlocation.md),
[`SetScreenLocation`](reference/builtins/setscreenlocation.md), and
[`SetCharsetAndScreenLocation`](reference/builtins/setcharsetandscreenlocation.md)
each place their respective data at a fixed offset *inside* that window
(only a handful of 2KB/1KB-aligned offsets are valid addresses for each,
enforced at compile time), by writing to the separate VIC-II register at
`$D018`.

## Raster interrupts

A raster interrupt fires when the VIC-II's beam reaches a chosen screen
line, the basis of every raster-bar/split-screen effect. Three registers
are involved: `$D01A` (interrupt-enable mask, one bit per interrupt
source), `$D012` (the raster line to compare against, low 8 bits), and
`$D011` bit 7 (the raster line's 9th bit, needed to reach lines 256 and
above on PAL). [`RasterIRQ`](reference/builtins/rasterirq.md) hooks an
`interrupt` procedure to a chosen line through either the raw 6502
hardware IRQ vector (`$FFFE`/`$FFFF`) or the KERNAL's own IRQ vector
(`$0314`/`$0315`), selected by its `<mode>` parameter; only the hardware
vector is available through [`RasterIRQWedge`](reference/builtins/rasterirqwedge.md),
see that page's Known limitations section.
[`EnableRasterIRQ`](reference/builtins/enablerasterirq.md) (and
[`StartRasterChain`](reference/builtins/startrasterchain.md), which
calls it) currently can't reach a raster line at or past 256, see that
page for why. None of `RasterIRQ`, `RasterIRQWedge`, or
[`StartIRQWedge`](reference/builtins/startirqwedge.md) validate their
own arguments before use, so a malformed call to any of them can crash
the compiler itself rather than failing with a normal error; see each
page's own Known limitations section.

Declaring a procedure `interrupt` (instead of plain `procedure`) is what
makes it end in the correct return instruction for an interrupt context;
see the [`interrupt`](reference/keywords/interrupt.md) keyword page for
the full setup pattern, and [`wedge`](reference/keywords/wedge.md) for
the wedge-chaining alternative to a plain vector hook.

## Compression: three unrelated mechanisms

This compiler ships three genuinely separate ways to shrink a program or
its data, none of which can read what one of the others wrote:

- **[`compressed`](reference/keywords/compressed.md) / [`@compress`](reference/directives/compress.md)**:
  both produce LZ4-compressed data, but even the two of *them* aren't
  interchangeable with each other (different LZ4 frame formats), and
  neither has a matching runtime decompress builtin on this target. See
  either page's Known limitations section.
- **[`Decrunch`](reference/builtins/decrunch.md) / [`DecrunchFromIndex`](reference/builtins/decrunchfromindex.md)**:
  unpack Exomizer-format data at runtime. The compiler doesn't crunch
  anything itself here; the data referenced through an
  [`IncBin`](reference/types/incbin.md) block has to already be
  Exomizer-crunched ahead of time, with the separate, external Exomizer
  command-line tool.
- **Whole-program SFX crunching**: a separate mechanism from either of
  the above, controlled by a project setting (`exomizer_toggle`) rather
  than any language keyword or builtin. When enabled, the compiler
  shells out to the same external Exomizer tool, but in self-extracting
  mode, crunching the entire finished `.prg` after assembly rather than
  a specific block of data; the result decompresses itself
  automatically when loaded, transparent to the program. This needs the
  Exomizer tool's path configured in the settings `.ini`, the same way
  [`@compress`](reference/directives/compress.md) needs the `lz4` tool's
  path configured there.

[`KrillLoad`](reference/builtins/krillload.md) /
[`KrillLoadCompressed`](reference/builtins/krillloadcompressed.md) are a
related but separate concern: a disk fastloader, not a compression
scheme in their own right, though `KrillLoadCompressed` layers on top of
the Exomizer format above.

## Build-time optimization settings

Two independent optimization passes run as part of a normal compile,
both opt-out rather than opt-in by default in the shipped project
templates:

- **Unused symbol removal**, a project-level setting
  (`remove_unused_symbols`): after parsing, the compiler drops any
  variable or procedure nothing in the program actually reads, calls, or
  references from inline assembly (a variable or procedure referenced
  only from inline `asm`/`assembler` code is still detected and kept,
  across the whole parsed program including `@use`d unit files, not just
  the file the inline assembly lives in). `IncBin`/`IncSid` blocks are
  never removed this way even if nothing references them, since their
  data still needs to end up in the output.
- **Peephole optimization of the generated assembly**
  (`post_optimize`, a global settings-file switch, on by default): a
  set of individually-toggleable passes, each named after the specific
  redundant instruction pattern it collapses (repeated loads, a
  store immediately followed by a matching load, redundant compares,
  chained jumps, and a few others), controlled per-project by the
  `post_optimizer_pass*` settings. All of them are enabled in the
  shipped project templates; turning one off is mostly a debugging aid
  for when generated code needs to be read or stepped through
  unmodified.

## Zero page usage

Several project settings carve up the C64's zero page (`$00`-`$FF`)
into pools the compiler draws from for its own bookkeeping, separate
from any zero-page bytes a program's own inline assembly might want to
use directly:

- `zeropages`: the general pool the compiler assigns pointer and array
  variables out of.
- `temp_zeropages`: scratch bytes used during expression evaluation
  and by a handful of builtins that need working storage of their own
  ([`ScrollX`](reference/builtins/scrollx.md)/[`ScrollY`](reference/builtins/scrolly.md)
  silently do nothing at all if this list is left empty, see either
  page's Known limitations section).
- `zeropage_internal1` through `4`: four bytes reserved for specific
  builtins' internal working state; [`Sqrt`](reference/builtins/sqrt.md)
  needs all four configured or it silently compiles to no code, see that
  page's Known limitations section.
- `zeropage_decrunch1` through `4`: four bytes reserved for the Exomizer
  decompressor's own working state, used by
  [`Decrunch`](reference/builtins/decrunch.md).
- `zeropage_screenmemory` / `zeropage_colormemory`: a single byte each,
  used as a pointer by the screen/color-memory-writing routines behind
  [`MoveTo`](reference/builtins/moveto.md)/[`PrintString`](reference/builtins/printstring.md)/[`Tile`](reference/builtins/tile.md).
- `zeropages_userdefined`: addresses the compiler is told to leave alone
  entirely, set aside for a program's own inline-assembly use.

Every shipped project template already populates all of these; they only
tend to matter if a project's settings file is trimmed down by hand and
one of the lists ends up empty.

## Source file roles

- **`.ras`**: the Pascal-like source itself. What gets passed as
  `input_file=` to the CLI (see
  [Getting Started](getting-started.md)).
- **`.tru`**: unit files, pulled in with [`@use`](reference/directives/use.md).
  A `@use <Name>` looks for `<Name>.tru` in the current source
  directory first, then in the standard library's per-system folder,
  then its shared 6502-family folder, then its fully shared `global`
  folder, in that order, and only ever includes the first match it
  finds.
- **`.asm`**: the intermediate 6502 assembly the compiler generates
  from a `.ras` file before assembling it to a `.prg`. Normally an
  implementation detail of a single compile, but the CLI also has a
  standalone mode to assemble an already-generated `.asm` file directly
  (`op=orgasm`), useful if the assembly output itself needs hand
  editing.
- **`.trse`**: the project settings file (zero-page layout, memory
  banking, per-project optimizer passes, and more, all covered above),
  one per project. Plain text, in `.ini` format, editable by hand.
- **`.ini`** (the settings file passed as `settings=`, distinct from the
  project's own `.trse` file): tooling-level settings shared across
  projects, not specific to any one of them: which assembler to use
  (`assembler = OrgAsm` or `dasm`), and the external tool paths
  (`lz4`, `exomizer`) the compression mechanisms above depend on.

See [Project & Settings Files](project-files.md) for a full, detailed
reference on every setting in both files.
