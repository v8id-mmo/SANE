# Changelog

All notable changes to SANE are recorded here.

This project doesn't cut versioned releases yet, it's an actively
developed nightly fork, so entries are grouped by date instead of a
version number. That will likely change once the project is stable enough
for real release tags; when it does, this file switches to that format
instead.

## Unreleased

Nothing pending right now.

## 20 July 2026

### Documentation

- Added the SANE / TRSE documentation site: a searchable reference
  covering every language keyword, builtin, operator, type, and
  predefined constant, cross-checked directly against the compiler
  source rather than upstream TRSE's own incomplete docs. Published
  incrementally, in small reviewed batches.
- Added a dedicated Known Bugs page, listing every confirmed compiler
  defect found so far in one place.
- Added a Project Goals page, laying out what this fork is actually
  trying to accomplish and what it deliberately isn't.
- Added this changelog.

## 19 July 2026

### Removed

- The entire GUI/IDE layer: the built-in source editor, the image/
  charset/sprite/level editor, the bundled software synthesizer, and the
  bundled CHIP-8 emulator. SANE is now a CLI-only compiler, meant to be
  invoked from the command line or driven from an external editor such as
  VS Code, not from its own built-in IDE.
- Support for every target system other than the Commodore 64: VIC-20,
  PET, C128, NES, Apple II, Atari 2600/800, Amiga, Z80/MSX/Spectrum,
  x86, and the rest of the systems upstream TRSE supports.

### Changed

- Trimmed the bundled project templates and tutorials down to Commodore
  64 content only.
- Cut the compiled binary from roughly 29.5MB to roughly 6.3MB as a
  result of the above.
