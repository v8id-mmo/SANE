# `@pathtool`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Intended as a build-time directive that fits a smooth curve through a list
of 2D points and samples it at regular intervals, writing the resulting
position (and direction) data to raw binary files for something like a
sprite following a path. Not currently usable; see Known limitations.

## Syntax

    @pathtool "<input file>" "<output base name>" <sampleCount> <degreeSteps>;

## Parameters

- `<input file>`: a plain text file of whitespace-separated coordinate
  points to fit a curve through.
- `<output base name>`: a filename prefix. Three files are produced from
  it: `<prefix>x.bin`, `<prefix>y.bin`, and `<prefix>t.bin` (position and
  direction data).
- `<sampleCount>`: how many evenly-spaced points to sample along the
  fitted curve.
- `<degreeSteps>`: scales the direction value written to the `t.bin` file,
  intended for picking one of several pre-rotated sprite frames along the
  path.

## Known limitations

**This directive does not currently compile, in any configuration.**
Placing `@pathtool` at the top level of a program, and inside a `var`
block (its only sensible location, since its output is meant to be
pulled in via `incbin`), both fail the same way. The directive's own
side effects (reading the input file, writing the three output `.bin`
files) do run successfully, but something afterward leaves the parser
out of sync with the rest of the file, and the resulting error surfaces
much later, worded as if the problem were a missing `begin` rather than
pointing at the `@pathtool` line itself. A sibling directive with a very
similar shape, [`@perlinnoise`](perlinnoise.md), compiles cleanly in the
exact same placement, so the problem is specific to `@pathtool`.

No working example exists to show here; a broken example would be worse
than none, so none is included on this page.
