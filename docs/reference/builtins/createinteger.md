# `CreateInteger`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Builds a 16-bit value from two separate byte expressions, one for the low
byte and one for the high byte, so it can be assigned straight into an
`integer` variable.

## Syntax

    <integer var> := CreateInteger( <loByte>, <hiByte> );

## Parameters

- `<loByte>`: the low (least significant) byte of the result.
- `<hiByte>`: the high (most significant) byte of the result.

## Returns

A 16-bit value equal to `<loByte> + (<hiByte> * 256)`.

## Example

```pascal
program CreateIntegerDemo;
var
	value : integer;
begin
	value := CreateInteger(10, 20); // value = 10 + 20*256 = 5130
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/createinteger.ras){ .md-button download }

## Known limitations

See [`CreatePointer`](createpointer.md): it's implemented as the exact
same routine as `CreateInteger`, not a distinct one, despite the
different name.
