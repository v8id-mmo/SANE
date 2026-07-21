# `@compress`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that LZ4-compresses a file on disk, by shelling
out to an external `lz4` command-line tool. Unlike the [`compressed`](../keywords/compressed.md)
variable flag (which uses the compiler's own bundled LZ4 implementation),
`@compress` needs a real `lz4` binary installed and configured.

## Syntax

    @compress "<source>" "<destination>";
    @compress "<source>" "<destination>" <split>;

## Parameters

- `<source>`: path (relative to the project directory) of the file to
  compress.
- `<destination>`: path to write the compressed output to.
- `<split>` (optional): if given and greater than 1, the source file is
  split into `<split>` equal-sized chunks first, and each chunk is
  compressed separately, written to `<destination>0`, `<destination>1`,
  etc. Omit it (or use `1`) to compress the whole file as one block.

## Setup

Requires the `lz4` command-line tool to be installed, with its path set
in the project's settings `.ini` under the `lz4` key (for example,
`lz4 = /usr/bin/lz4`). Compilation fails with an explicit error if that
path doesn't exist.

## Example

```pascal
program CompressDemo;

@compress "sample_data.bin" "sample_data.lz4"

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/compress.ras){ .md-button download }
(also needs [`sample_data.bin`](../../assets/examples/sample_data.bin) in
the same folder)

## Known limitations

Same underlying gap as [`compressed`](../keywords/compressed.md): there is no
compiler builtin that decompresses this data back at runtime, and
`decrunch()` cannot be used on it (it only accepts `IncBin`-typed data,
and decompresses a different format, Exomizer, not LZ4). On top of that,
`@compress`'s output isn't even the same *container* as `compressed`'s:
`@compress` (which runs the external `lz4` tool with the `-l` flag)
produces the **legacy** LZ4 frame format (magic bytes `$02 $21 $4c
$18`), while `compressed`'s bundled `CompressLZ4` produces the modern
LZ4 frame format (magic bytes `$04 $22 $4d $18`). The two aren't
interchangeable either.
