# `CreatePointer`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Builds a 24-bit-addressable pointer value from two separate byte
expressions, one for the low byte and one for the high byte, so it can be
assigned straight into a `pointer` variable.

## Syntax

    <pointer var> := CreatePointer( <loByte>, <hiByte> );

## Parameters

- `<loByte>`: the low byte of the result.
- `<hiByte>`: the high byte of the result.

## Returns

A value equal to `<loByte> + (<hiByte> * 256)`.

## Example

```pascal
program CreatePointerDemo;
var
	target : pointer;
begin
	target := CreatePointer(10, 20); // target = 10 + 20*256 = 5130
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/createpointer.ras){ .md-button download }

## Known limitations

`CreatePointer` and [`CreateInteger`](createinteger.md) compile to
byte-for-byte identical assembly. Both always put the high byte in the Y
register; neither ever loads, stores, or touches the X register.
Assigning the result of `CreatePointer` to a `pointer` variable produces
exactly the same code as assigning `CreateInteger`'s result to an
`integer` variable, so there's currently no actual behavioral difference
between the two builtins beyond the name.
