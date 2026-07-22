# `setHi`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Writes a byte into the high byte of a 2-byte (`pointer` or `integer`)
variable, without disturbing its low byte. The write counterpart to
[`Hi`](hi.md), which only reads.

## Syntax

    setHi(target, value : byte)

## Parameters

- `target`: a `pointer` or `integer` variable.
- `value`: the byte to write into `target`'s high byte.

## Example

```pascal
program SetHiDemo;
var
	myInteger : integer;
	myPointer : pointer;
begin
	setHi(myInteger, $33);
	setHi(myPointer, $12);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/sethi.ras){ .md-button download }
