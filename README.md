<div align="center">

![SANE Logo](resources/images/trse_optic.png)

# SANE

*Syntax And Not Errors:* a lean, CLI-only, C64-only fork of TRSE.

**A Pascal-like language and 6502 compiler for the Commodore 64,
stripped down to exactly what that means and not one byte more.**

[![License: GPL v3](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE.txt)
[![Target: C64](https://img.shields.io/badge/target-Commodore%2064-6c5ce7.svg)](https://en.wikipedia.org/wiki/Commodore_64)
[![CLI only](https://img.shields.io/badge/interface-CLI--only-2d3436.svg)](#what-is-sane)

[Documentation](https://v8id-mmo.github.io/SANE/) · [Changelog](CHANGELOG.md) · [Known Bugs](CHANGELOG.md)

</div>

---

## What is SANE?

SANE is a personal, internal-use fork of
[leuat/TRSE](https://github.com/leuat/TRSE) (*Turbo Rascal Syntax Error,
";" expected but "BEGIN"*), the Pascal-like compiler suite for retro
8/16-bit systems.

The original TRSE is a full IDE: editor, sprite/charset/level editors, a
built-in synthesizer, a bundled CHIP-8 emulator, and support for a couple
dozen target systems from the Apple II to the SNES. SANE deliberately
throws almost all of that away and keeps exactly one thing: **a compiler
for the Commodore 64, driven entirely from the command line.**

No GUI. No IDE. No other target systems. Just `trc -cli`, your source
file, and a `.prg`.

```sh
./build/trse -cli op=project project=myproj.trse input_file=main.ras \
    settings=Publish/publish_linux/trse.ini
```

## Why fork it?

TRSE's IDE is built for the general case: dozens of systems, a built-in
editor, asset tools for every platform it targets. None of that is needed
when the workflow is "write `.ras`/`.pas` in VS Code, compile from the
terminal, test in VICE." Cutting it down means:

- **A binary that's ~5x smaller** (~6.3 MB vs. ~29.5 MB), because the
  GUI/IDE layer and every non-C64 target system are gone.
- **A much smaller surface to reason about.** `systems/` / `codegen/` /
  `compilers/` / `assembler/` / `optimiser/` combined are down to 17
  `.cpp` files.
- **One clear entry point.** `-cli` mode (`trc.cpp` / `ClascExec`) is the
  only way in; `main.cpp` is `-cli`-only.

This is **not** a general-purpose retro-compiler distribution and makes
no promise of compatibility with upstream TRSE. It exists to compile C64
programs, well, for one person, from one editor.

## Status

Actively developed, nightly-branch pace, no versioned releases yet. See
[CHANGELOG.md](CHANGELOG.md) for the running list of changes.

Two structural cleanup items are still open (trimming `units/` to
C64-only, matching what already happened to `Publish/`), followed by a
set of confirmed compiler bugs (signed arithmetic, several `@`-directives,
a handful of builtins) that are tracked, reproduced with regression
snippets, and fixed one at a time. All of it lives in the shared
6502/C64 codegen; none of it touches unrelated platforms.

An interactive documentation site (every keyword, every builtin, worked
examples, known-limitation callouts) is being built alongside the fixes:

**→ [v8id-mmo.github.io/SANE](https://v8id-mmo.github.io/SANE/)**

## Building

SANE currently still builds from `TRSE.pro` (the full GUI project file),
not `TRSECLI.pro`: the latter is five years stale and references files
that no longer exist. The resulting `trse` binary still links Qt Widgets
at build time, but is used purely as a headless CLI compiler in practice.
A genuinely GUI-less `.pro` is future work.

### Linux

```sh
sudo apt-get install -y \
    build-essential \
    qtbase5-dev qtbase5-dev-tools qt5-qmake \
    qtdeclarative5-dev qtdeclarative5-dev-tools \
    libqt5opengl5-dev \
    mesa-common-dev libgl1-mesa-dev

./compile.sh
```

This builds out-of-source into `./build`, producing `./build/trse`.
See the header of [`compile.sh`](compile.sh) for `--clean`, `--debug`,
and `-jN` options.

### Windows

- Install MSVC 2019.
- Install the Qt framework ([qt.io/download](https://www.qt.io/download), Qt6, desktop).
- `qmake TRSE.pro && make -j8` (or build via Qt Creator).

### macOS

- Install Xcode.
- Install the Qt framework ([qt.io/download](https://www.qt.io/download), Qt6, desktop).
- `qmake TRSE.pro && make -j8`.

### After building

A couple of resource directories need to be reachable from the build
output directory. See `create_symlinks_linux.sh` /
`create_symlinks_osx.sh` for the exact links (themes, tutorials, units,
project templates).

### Trying it out

```sh
cd test_projects
../build/trse -cli op=project project=project.trse input_file=main.ras \
    settings=../Publish/publish_linux/trse.ini
```

`test_projects/` (see its own [README](test_projects/README.md)) holds a
handful of known-working `.ras` snippets for a quick sanity check after
touching codegen.

## Project layout

```text
source/            compiler, parser, codegen, assembler, optimiser (Qt/C++)
Publish/           project templates and C64 tutorials
units/             shared standard library (@use-able .tru units)
test_projects/     scratch smoke-test snippets for the CLI pipeline
docs/              MkDocs source for the documentation site
```

## License

GPL-3.0, inherited from upstream TRSE. See [LICENSE.txt](LICENSE.txt).

## Credits

Built on top of the excellent work of [leuat/TRSE](https://github.com/leuat/TRSE)
and the Turbo Rascal community. All C64 codegen, parser, and language
design originate there; this fork only removes and fixes.
