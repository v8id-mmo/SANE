# `compressed`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A flag on an array, string, or c-string declaration that compresses its
initializer data at compile time (using the compiler's own bundled LZ4
implementation), so it takes up less space in the final `.prg`.

## Syntax

    var
      <name> : array[<count>] of <type> compressed = (<values>);

The flag can also appear right after `of`, before the element type
(`array[<count>] of compressed <type> = (...)`); both positions are
accepted.

## Example

```pascal
program CompressedDemo;
var
	packedData : array[32] of byte compressed = (
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	);

begin
	screen_bg_col := packedData[0];
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/compressed.ras){ .md-button download }

## Known limitations

**No compiler builtin decompresses this data back at runtime.** Confirmed
by tracing the compression path in the source: `compressed` always
produces LZ4-framed data via `AbstractSystem::CompressLZ4` (confirmed by
inspecting the generated `.asm`: the array starts with the literal modern
LZ4 frame magic bytes `$04 $22 $4d $18`). The only decompression builtin,
`decrunch()`, explicitly refuses anything that isn't an `IncBin`-typed
variable (`Decrunch: parameter 0 must be a pointer to a IncBin block or
address!`, confirmed by testing), and its actual runtime routine
(`exod_decrunch`, in `resources/code/init_decompress.asm`) is an
**Exomizer** decruncher, an unrelated compression format from LZ4.
Nothing in the bundled runtime library (`resources/code/`) contains an
LZ4 decompressor either. In short: `compressed` and `decrunch()` are two
independent compression schemes that don't interoperate, and only the
Exomizer side (via `IncBin` + `decrunch()`) currently has a way back to
the original data from within a running program.

The [`@compress`](compress.md) build directive has the exact same gap
(nothing decompresses its output at runtime either), but is not even the
same LZ4 container as this flag: `@compress` shells out to an external
`lz4` tool with the `-l` flag, which produces the **legacy** LZ4 frame
format (magic `$02 $21 $4c $18`), not the modern one `compressed` uses.
See `CLAUDE.md` section 2.11 for the full writeup.
