# Changelog

All notable changes to SANE are recorded here.

This project doesn't cut versioned releases yet, it's an actively
developed nightly fork, so changes are listed as a simple running list
below instead of being grouped by version. Newest at the top, oldest at
the bottom. Once the project is stable enough for real release tags,
this switches to that format instead.

- Fixed the documentation site's navigation and color scheme
- Split the documentation site's `@`-prefixed build directives out of
  the Keywords reference category into their own dedicated Directives
  category, for a clearer, more searchable site structure.
- Completed the Operators reference category on the documentation site
- Found and documented several new confirmed compiler defects while
  writing the Operators pages: signed right shift (`shr`/`>>`) always
  performs a logical shift and never preserves the sign; 24-bit `long`
  bitwise `&`/`|`/`xor`/`^` miscompute the result when the right-hand
  operand isn't a plain variable; `xor` used to combine two conditions
  always evaluates true instead of actually combining them; and `not` on
  a 16-bit or 24-bit value only complements the low byte, and can't
  correctly negate a parenthesized comparison.
- Completed the Keywords reference category on the documentation site
  (all 103 keywords), each with a compiled example and known-limitation
  callouts where applicable.
- Added the SANE / TRSE documentation site. Published incrementally,
  in small reviewed batches.
- Added a dedicated Known Bugs page, listing every confirmed compiler
  defect found so far in one place.
- Added a Project Goals page, laying out what this fork is actually
  trying to accomplish and what it deliberately isn't.
- Added this changelog.
- Removed the entire GUI/IDE layer: the built-in source editor, the
  image/charset/sprite/level editor, the bundled software synthesizer,
  and the bundled CHIP-8 emulator. SANE is now a CLI-only compiler, meant
  to be invoked from the command line or driven from an external editor
  such as VS Code, not from its own built-in IDE.
- Removed support for every target system other than the Commodore 64:
  VIC-20, PET, C128, NES, Apple II, Atari 2600/800, Amiga,
  Z80/MSX/Spectrum, x86, and the rest of the systems vanilla TRSE
  supports.
- Trimmed the bundled project templates and tutorials down to Commodore
  64 content only.
- Cut the compiled binary from roughly 29.5MB to roughly 6.3MB as a
  result of the above.
