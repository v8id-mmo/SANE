# `KrillLoad`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Loads a file from disk using Krill's fastloader, once
[`InitKrill`](initkrill.md) has installed it. For the compressed variant,
see [`KrillLoadCompressed`](krillloadcompressed.md).

On success, execution continues normally. On a load error, the machine
freezes and repeatedly increments the border color ($D021), producing a
visible flashing-border failure indicator rather than returning an error
code the program could check.

## Syntax

    KrillLoad( <filename> )

## Parameters

- `<filename>`: a variable holding, or pointing to, a zero-terminated
  filename string.

## Example

```pascal
program KrillLoadDemo;

@use KrillsLoader $0200 $2000 $3000

var
	filename : cstring = "DATA.BIN";

begin
	InitKrill();
	KrillLoad(#filename);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/krillload.ras){ .md-button download }
