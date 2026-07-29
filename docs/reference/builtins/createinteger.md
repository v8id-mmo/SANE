# `CreateInteger`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
built this value with the low/high bytes swapped relative to the
documented parameter order; SANE fixes it.

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

See [`CreatePointer`](createpointer.md): in vanilla TRSE, it's implemented
as the exact same routine as `CreateInteger`, not a distinct one, despite
the different name; SANE gives it a small addition of its own (also
loading the result into X), while `CreateInteger` itself is unchanged.

Separately, in vanilla TRSE, this builtin actually builds its result with
the low and high byte positions swapped relative to the documented
`(loByte, hiByte)` order: `CreateInteger(10, 20)` does **not** equal
`5130` as the example above's comment claims; `CreateInteger(20, 10)`
does.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the low/high byte order now matches the documented `(loByte, hiByte)`
parameters, so the example above is accurate on SANE.
