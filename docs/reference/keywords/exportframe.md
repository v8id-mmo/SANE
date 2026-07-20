# `@exportframe`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that exports one or more "frames" from a `.flf`
image/asset to a raw binary file. What a "frame" means depends on the
asset type: for a level-editor asset it's a level number; the directive
was also intended to support animation-frame export from charset/sprite
assets (see Known limitations below). See [`@export`](export.md) for what
`.flf` is and where it comes from.

## Syntax

    @exportframe "<input .flf file>" "<output file>" <frame> <frameCount> <type> <col> <row> <width> <height> <rowOrder>;

## Parameters

- `<input .flf file>`: path to the `.flf` asset to export. Compilation
  fails with an error if it doesn't exist.
- `<output file>`: path to write the raw binary export to.
- `<frame>`: first frame/level index to export.
- `<frameCount>`: how many consecutive frames/levels to export, starting
  at `<frame>`.
- `<type>`: for a level-editor asset: `0` = level data, `1` = colour data,
  `2` = extra data (background/aux colours plus per-row extra data), `3` =
  all of the above, sequentially.
- `<col>`, `<row>`: starting column/row within each frame.
- `<width>`, `<height>`: how many columns/rows to export; `0` for either
  means "use the frame's full width/height".
- `<rowOrder>`: `0` = column order (full colour map), `1` = row order
  (full colour map), `2` = column order (half/double-height colour map),
  `3` = row order (half/double-height colour map).

## Example

```pascal
program ExportFrameDemo;

@exportframe "sample_level.flf" "sample_level_frame.bin" 0 1 0 0 0 0 0 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportframe.ras){ .md-button download }
(also needs [`sample_level.flf`](../../assets/examples/sample_level.flf) in
the same folder)

## Known limitations

**Only actually implemented for level-editor assets.** Confirmed by
reading the source: `ImageLevelEditor::ExportFrame`
(`imageleveleditor.cpp`) is a real implementation, and is what the example
above uses. But the charset-family implementation,
`CharsetImage::ExportFrame` (`charsetimage.cpp`), is a dead stub: it
declares an output buffer, never appends anything to it, and writes that
empty buffer to the output file. Since `CharsetImage` is the base class
for most other `.flf` asset types (sprite sheets included), pointing
`@exportframe` at anything other than a level-editor asset compiles
without error but silently produces a zero-byte output file.
