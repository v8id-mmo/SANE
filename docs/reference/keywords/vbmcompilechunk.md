# `@vbmcompilechunk`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A build-time directive that reads a region of an image asset and writes
out real TRSE source code: one procedure per column, each containing a
hand-built inline-assembly routine that draws that column's non-empty
character rows through a pointer, plus a lookup table of pointers to all
those procedures. Meant for fast, self-drawing raster/level chunks rather
than a generic data export.

## Syntax

    @vbmcompilechunk "<input file>" "<output file>" "<procedure name>" "<pointer name>" "<extra asm opcode>" <start> <width> <height> <is multicolor>;

## Parameters

- `<input file>`: path to the source image asset (an `.flf` file).
- `<output file>`: path to write the generated TRSE source to.
- `<procedure name>`: base identifier for the generated
  `<procedure name>_0`, `<procedure name>_1`, ... procedures and for the
  lookup-table array itself.
- `<pointer name>`: the identifier of a `pointer` variable the generated
  drawing code writes through (`sta (<pointer name>),y`). That variable
  needs to actually exist wherever the generated code is
  [`@include`](include.md)d.
- `<extra asm opcode>`: optional; when non-empty, this opcode is also
  applied at `(<pointer name>),y` right before the `sta`, e.g. `"ora"` to
  merge onto existing screen data instead of overwriting it. Pass `""` to
  skip this.
- `<start>`: index into the image's character grid to start reading from.
- `<width>`, `<height>`: size, in characters, of the region to read.
- `<is multicolor>`: `1` if the source asset uses multicolor mode
  (affects how each character's pixel data is interpreted), `0` otherwise.

## Example

```pascal
program VbmCompileChunkDemo;

@vbmcompilechunk "sample_sprite.flf" "sample_sprite_chunk.inc" "DrawChunk" "myPtr" "" 0 4 4 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/vbmcompilechunk.ras){ .md-button download }
(also needs [`sample_sprite.flf`](../../assets/examples/sample_sprite.flf)
in the same folder)

## Known limitations

The generated output file cannot be [`@include`](include.md)d in the
*same* compile that generates it: on a clean build, `@include` for the
generated file fails with "Could not open file for inclusion", even
though `@vbmcompilechunk` runs first in the same file, the same failure
shape as [`@bin2inc`](bin2inc.md#known-limitations). Generate the file
with one compile first, then `@include` it from a separate compile.
