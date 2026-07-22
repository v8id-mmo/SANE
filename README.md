<div align="center">

![SANE Logo](resources/images/trse_optic.png)

# SANE

*Signed Arithmetic, No Errors:* a lean, CLI-only & C64-only fork of TRSE

**A Pascal-like language and 6502 compiler for the Commodore 64**

[![License: GPL v3](https://img.shields.io/badge/license-GPL--3.0-blue.svg)](LICENSE.txt)
[![Target: C64](https://img.shields.io/badge/target-Commodore%2064-6c5ce7.svg)](https://en.wikipedia.org/wiki/Commodore_64)
[![CLI only](https://img.shields.io/badge/interface-CLI--only-2d3436.svg)](#what-is-sane)

[Documentation](https://v8id-mmo.github.io/SANE/) · [Changelog](CHANGELOG.md) · [Known Bugs](https://v8id-mmo.github.io/SANE/known-bugs/)

</div>

---

## What is SANE?

SANE is a **Commodore 64-only**, and **CLI-only** TRSE compiler, a fork of
[TRSE (Turbo Rascal Syntax Error)](https://github.com/leuat/TRSE), a
Pascal-like full development environment for 8-bit systems.

It is 99.99% TRSE-compatible: if you already know **TRSE**, almost everything here works
exactly as it does in the original.

## Why this exists

This started as a personal project, meant to make my own C64 development
easier and more reliable. Once it was in reasonable shape, it seemed like
it could plausibly help other people hitting the same walls too, so
sharing it publicly was an easy call.

TRSE is a genuinely good Pascal compiler for 8-bit systems, but using it
meant working inside its own bundled IDE, dealing with quirks that had been sitting unfixed for a long time, and
reaching for community forum threads whenever the official documentation
didn't cover something (which was often). Rather than trying to fix all
of that in the full, every-platform version of TRSE, SANE narrows the
scope on purpose: one target (the Commodore 64), one workflow (the
command line), and a small, concrete list of things to do:

- **A CLI tool only.** No bundled editor, no bundled image/sprite/
  level editor, no GUI framework.
- **Complete and up-to-date documentation.** Every
  keyword, builtin, operator, type, and constant, cross-checked against
  the real compiler source rather than copied from TRSE's
  own docs.
- **Fix known bugs continuously**, instead of quietly working around them
  project after project. See [Known Bugs](https://v8id-mmo.github.io/SANE/known-bugs/) for the
  current list.
- **VS Code integration**: syntax highlighting, a
  build task that jumps straight to the offending line on a compile
  error, and proper project/settings configuration from inside the
  editor, and other fancy things.

SANE is **not** trying to:
- be a multi-platform retro compiler or a fully functional development environment
- merge back into upstream TRSE or track it release-for-release. See
[Project Goals](https://v8id-mmo.github.io/SANE/goals/) for the full
picture, including what's deliberately out of scope.

Because under the hood everything stays deeply TRSE-compatible, most of what's built
here (documentation, bug fixes) benefits anyone using plain classic TRSE
too, **not just SANE users**.

## Status

Almost actively developed, no versioned releases yet. See

[CHANGELOG.md](CHANGELOG.md) for the running list of changes
[Known Bugs](https://v8id-mmo.github.io/SANE/known-bugs/) for the list of currently known bugs

## Docs

An interactive documentation site about the full TRSE / SANE language:

**→ [v8id-mmo.github.io/SANE](https://v8id-mmo.github.io/SANE/)**

## Building

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

Built on top of the **excellent work** of [leuat/TRSE](https://github.com/leuat/TRSE) and the Turbo Rascal community.

All C64 codegen, parser, and language design originate there; this fork only removes and fixes.
