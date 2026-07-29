# `CreatePointer`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
built this value with the low/high bytes swapped relative to the
documented parameter order, and never actually used the X register
despite `CreatePointer`'s name implying it should; SANE fixes both.

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

In vanilla TRSE, `CreatePointer` and [`CreateInteger`](createinteger.md)
compile to byte-for-byte identical assembly. Both always put the high
byte in the Y register; neither ever loads, stores, or touches the X
register. Assigning the result of `CreatePointer` to a `pointer` variable
produces exactly the same code as assigning `CreateInteger`'s result to
an `integer` variable, so there's currently no actual behavioral
difference between the two builtins beyond the name.

Separately, in vanilla TRSE, both builtins actually build the result with
the low and high byte positions swapped relative to the documented
`(loByte, hiByte)` order: `CreatePointer(10, 20)` does **not** equal
`5130` as the example above's comment claims; `CreatePointer(20, 10)`
does. This affects [`CreateInteger`](createinteger.md) identically, since
they share one implementation.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the low/high byte order now matches the documented `(loByte, hiByte)`
parameters (the example above is accurate on SANE), and `CreatePointer`
now also loads its result's high byte into X, so its result is usable via
X immediately after the call, distinct from `CreateInteger`.
