# `KrillLoadCompressed`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Same as [`KrillLoad`](krillload.md), but loads a file that was compressed
for Krill's loader (via the tinycrunch tool, see the
[`krillsloader`](../keywords/krillsloader.md) reference), decompressing
it as it streams in from disk. Same load-failure behavior as `KrillLoad`:
the machine freezes with a flashing border on error, no error code is
returned.

## Syntax

    KrillLoadCompressed( <filename> )

## Parameters

- `<filename>`: a variable holding, or pointing to, a zero-terminated
  filename string for the compressed file.

## Example

```pascal
program KrillLoadCompressedDemo;

@use KrillsLoader $0200 $2000 $3000

var
	filename : cstring = "DATA.TC";

begin
	InitKrill();
	KrillLoadCompressed(#filename);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/krillloadcompressed.ras){ .md-button download }
