# `@importchar`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

A build-time directive intended to copy a single character/tile from one
image asset into another, at a given position in each. See
[`@export`](export.md) for what `.flf` is and where it comes from.

## Syntax

    @importchar "<input file>" "<output .flf file>" <srcChar> <dstChar>;

## Parameters

- `<input file>`: path to the source data to copy a character from. Either
  a raw binary file (`.bin`/`.chr`) or another `.flf` asset.
- `<output .flf file>`: path to an existing `.flf` asset to copy into.
  Compilation fails with an error if it doesn't already exist; unlike
  `@bin2inc`, this directive edits an existing asset in place rather than
  creating one from scratch.
- `<srcChar>`: index of the character to read from the input.
- `<dstChar>`: index of the character slot to write into, in the output
  asset.

## Example

```pascal
program ImportCharDemo;

@importchar "sample_char.bin" "sample_scene.flf" 0 0

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/importchar.ras){ .md-button download }
(also needs [`sample_char.bin`](../../assets/examples/sample_char.bin) and
[`sample_scene.flf`](../../assets/examples/sample_scene.flf) in the same
folder)

## Known limitations

**The actual character-copy step is unimplemented for every asset type
this fork can produce, so `@importchar` compiles without error but never
changes the output file.** Both the input and output files are loaded
successfully, but the step that's supposed to copy one character's data
across falls back to a do-nothing default for every reachable C64 asset
type (charset, sprite, multicolor bitmap, full-screen character, etc.).
Only one unrelated, non-C64 asset type actually implements it. The output
`.flf` file is saved back to disk byte-for-byte identical to how it
started; confirmed by comparing the file's contents before and after
compiling the example above.
