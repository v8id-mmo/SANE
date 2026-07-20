# `@spritecompiler`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

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

## Example

```pascal
program SpriteCompilerDemo;

@spritecompiler "sample_sprite.flf" "mysprite" 0 0 8 8

begin
	loop();
end.
```

This compiles cleanly (per this site's rule that every example must
compile), but produces no output at all; see Known limitations.

[:material-download: Download this example](../../assets/examples/spritecompiler.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)

## Known limitations

**On a C64 target, this directive silently produces no output whatsoever,
on every asset type, with no error or warning.** The file-existence check
still runs (a missing input file does fail compilation), but the actual
sprite-compiling step is a no-op for every C64-reachable asset type. Even
on the handful of other, non-C64 targets where this step is implemented,
whatever it generates is computed and then discarded internally, never
actually reaching the compiled output. In practice, `@spritecompiler`
currently has no working use on any target this fork ships with.
