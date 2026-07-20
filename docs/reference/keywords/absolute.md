# `absolute`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a variable at a fixed, specific memory address instead of letting
the compiler pick where it lives. `absolute` is a synonym for [`at`](at.md);
the parser accepts either keyword in the same position and treats them
identically.

## Syntax

    var
      <name> : <type> absolute <address>;

`<address>` is a constant address expression: a literal (decimal or `$hex`)
optionally combined with `+`, `-`, `&`, `|` and parentheses.

## Parameters

- `<address>`: the fixed memory address the variable is placed at.

## Example

```pascal
program AbsoluteDemo;
var
	backgroundColor : byte absolute $d021;

begin
	backgroundColor := 6;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/absolute.ras){ .md-button download }

## Known limitations

`absolute` is accepted for plain byte/word/array/string variable
declarations, but **not** for pointer declarations (`^byte`/`^integer` at
a fixed address). The parser only checks for the `at` keyword in the
pointer-declaration branches, not `absolute` (confirmed in
`parser.cpp`'s `TypeSpec`). Use `at` instead of `absolute` when declaring
a pointer at a fixed address.
