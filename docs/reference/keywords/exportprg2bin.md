# `@exportprg2bin`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A build-time directive that extracts a byte range from an existing
compiled `.prg` file (its own 2-byte load address, plus everything after
it) into a raw binary slice. Useful for pulling out a piece of a
previously-built program, for example to embed part of one program's
compiled output inside another.

## Syntax

    @exportprg2bin "<input .prg file>" "<output file>" <from> <to>;

## Parameters

- `<input .prg file>`: path to an existing `.prg` file. Its first two
  bytes (the C64 load address) are read to establish where the rest of the
  file's contents actually start in memory.
- `<output file>`: path to write the extracted bytes to. If this path
  itself ends in `.prg`, a 2-byte load-address header (`<from>`, little
  endian) is written before the extracted bytes; otherwise the output is
  the raw bytes only.
- `<from>`, `<to>`: the address range to extract (`<to>` exclusive). Any
  address in the range that falls outside what the input file actually
  contains is filled with `0` bytes rather than causing an error.

## Example

```pascal
program ExportPrg2BinDemo;

@exportprg2bin "stub_prg_source.bin" "stub_slice.bin" $0801 $080B

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/exportprg2bin.ras){ .md-button download }
(also needs [`stub_prg_source.bin`](../../assets/examples/stub_prg_source.bin),
a tiny pre-built `.prg` file, in the same folder)
