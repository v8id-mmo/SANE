# Changelog

All notable changes to SANE are recorded here.

This project doesn't cut versioned releases yet, it's a (not so) actively
developed fork, so changes are listed as a simple running list
below instead of being grouped by version. Newest at the top, oldest at
the bottom. Once the project is stable enough for real release tags,
this switches to that format instead.

- Fixed `SpritePos` corrupting VIC-II registers on a sprite number of `8`
  or higher (now masked to the real `0`-`7` hardware range, for both a
  compile-time-constant and a runtime sprite number); `SetSpriteLoc` not
  actually enforcing its documented `0`-`3` `bank` range or checking a
  constant sprite number against `0`-`7`; and `RasterIRQ`, `RasterIRQWedge`,
  `StartIRQWedge` (and by extension `StartRasterChain`) crashing the
  compiler process instead of reporting a clean compile error on a
  malformed argument.
- Fixed `FOR`/`FORI`, `FLD`, `MemCpy`/`MemCpyFast`, and `Wait` all running
  their loop body at least once even when the count/range was already
  empty (a `for`/`fori` end value behind the start value, or a runtime
  count of `0`); all now correctly skip the loop entirely instead of
  wrapping around.
- Fixed `CopyCharsetFromRom` and `InitKrill` leaving interrupts disabled
  and never re-enabling them.
- Fixed `ScrollX`/`ScrollY`, `SetBank`, `SetBitmapMode`, and
  `EnableRasterIRQ`/`StartRasterChain` writing their VIC-II/CIA register
  unmasked or with a hardcoded value, clobbering unrelated bits (serial
  bus lines, Y-scroll, raster-compare high bit) on every call; all now do
  a masked read-modify-write. `ScrollX`/`ScrollY`/`SetBank` also now raise
  a compile error instead of silently no-opping when the project's
  `temp_zeropages` setting isn't configured.
- Fixed a relational comparison (`<`, `<=`, `>`, `>=`) between an unsigned
  byte and the literal `0` giving the wrong result for every operator
  except `=`/`<>`.
- Fixed `case ... else <single statement>; end;` desyncing the parser.
- Fixed `inline` procedure parameters not being reliably evaluated when a
  complex expression was referenced more than once in the procedure body,
  and `sine[]`'s auto-init table-fill not triggering when `sine[` was only
  used inside a `@use`d unit.
- Fixed signed arithmetic across the board: comparisons (`<`, `<=`, `>`,
  `>=`, `=`, `<>`) now work for signed `integer` and signed `long` values,
  not just `<`/`<=` on `integer`; byte-level signed comparisons are now
  correct at the sign boundary; signed multiplication now gives a correct
  result once the product widens to an `integer`; signed division now
  gives a correct result for `mod`/`mod16` (any width) and for `/` once
  the quotient widens to an `integer` (a plain `byte / byte` division
  staying a `byte` result is still unsigned only); and a negative
  `signed byte` mixed into a wider expression is now sign-extended instead
  of zero-extended.
- Added a Platform Notes page to the documentation site: RAM/ROM
  banking, VIC-II bank switching, raster interrupts, the three unrelated
  compression mechanisms (including a whole-program self-extracting
  crunch option not documented anywhere else on the site), build-time
  optimization settings, zero-page usage, and source file roles.
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
