# `setLo`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Writes a byte into the low byte of a 2-byte (`pointer` or `integer`)
variable, without disturbing its high byte. The write counterpart to
[`Lo`](lo.md), which only reads. The mirror image of
[`setHi`](sethi.md).

## Syntax

    setLo(target, value : byte)

## Parameters

- `target`: a `pointer` or `integer` variable.
- `value`: the byte to write into `target`'s low byte.

## Example

```pascal
program SetLoDemo;
var
	myInteger : integer;
	myPointer : pointer;
begin
	setLo(myInteger, $33);
	setLo(myPointer, $12);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setlo.ras){ .md-button download }
