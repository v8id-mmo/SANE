# `@spritecompiler`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE silently produces no output for this directive on any target; SANE
fails with a clear compile error instead.

Intended as a build-time directive that reads a region out of an image
asset and generates sprite-drawing code for it. Not currently usable on
this fork's target; see Known limitations.

## Syntax

    @spritecompiler "<input file>" "<name>" <x> <y> <w> <h>;
    @spritecompiler "<input file>" "<name>" <x> <y> <w> <h> "<param>";

## Parameters

- `<input file>`: path to the image asset to read from. Compilation fails
  with an error if it doesn't exist.
- `<name>`: a label used to name whatever output the directive would
  generate.
- `<x>`, `<y>`, `<w>`, `<h>`: region of the source image to compile.
- `<param>` (optional): an extra string parameter, meaning depends on the
  target.

**No example is shown on this page.** This directive always fails to
compile on SANE (see Known limitations below), so a working example
can't be given; a broken example is worse than none.

## Known limitations

**On a C64 target, this directive silently produces no output whatsoever,
on every asset type, with no error or warning, in vanilla TRSE.** The
file-existence check still runs (a missing input file does fail
compilation), but the actual sprite-compiling step is a no-op for every
C64-reachable asset type. Even on the handful of other, non-C64 targets
where this step is implemented, whatever it generates is computed and
then discarded internally, never actually reaching the compiled output.
In practice, `@spritecompiler` has no working use on any target that
compiler ships with.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
since this directive can never produce any output on this fork's C64-only
target, using it now stops compilation with a clear error instead of
silently doing nothing.
