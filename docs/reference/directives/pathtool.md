# `@pathtool`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
can't compile `@pathtool` in any configuration; SANE fixes this, see Known
limitations below.

A build-time directive that fits a smooth curve through a list of 2D
points and samples it at regular intervals, writing the resulting
position (and direction) data to raw binary files for something like a
sprite following a path.

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

## Example

```pascal
program PathtoolDemo;
var

@pathtool "pathtool_input.txt" "pathtool_out_" 4 8
	pathX : incbin("pathtool_out_x.bin");
	i : byte;

begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring("x0:",0,40);
	moveto(4,0,hi(screen_char_loc));
	printdecimal(pathX[0],3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pathtool.ras){ .md-button download }
(also needs [`pathtool_input.txt`](../../assets/examples/pathtool_input.txt)
in the same folder)

## Known limitations

**In vanilla TRSE, this directive does not compile, in any configuration.**
Placing `@pathtool` at the top level of a program, and inside a `var`
block (its only sensible location, since its output is meant to be
pulled in via `incbin`), both fail the same way. The directive's own
side effects (reading the input file, writing the three output `.bin`
files) do run successfully, but something afterward leaves the parser
out of sync with the rest of the file, and the resulting error surfaces
much later, worded as if the problem were a missing `begin` rather than
pointing at the `@pathtool` line itself. A sibling directive with a very
similar shape, [`@perlinnoise`](perlinnoise.md), compiles cleanly in the
exact same placement, so the problem was specific to `@pathtool`.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`@pathtool` now consumes all of its own arguments correctly and compiles
cleanly, in the same placements described above.
