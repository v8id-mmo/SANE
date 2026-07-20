# `at`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a variable at a fixed, specific memory address instead of letting
the compiler pick where it lives. This is how TRSE lets you name a
hardware register (a VIC-II or SID register, for example) as if it were an
ordinary variable. [`absolute`](absolute.md) is a synonym with the same
effect for plain variable declarations.

## Syntax

    var
      <name> : <type> at <address>;

`<address>` is a constant address expression: a literal (decimal or `$hex`)
optionally combined with `+`, `-`, `&`, `|` and parentheses.

## Parameters

- `<address>`: the fixed memory address the variable is placed at.

## Example

```pascal
program AtDemo;
var
	borderColor : byte at $d020;

begin
	borderColor := 0;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/at.ras){ .md-button download }

## Known limitations

On a pointer declaration (`^byte at <address>`), `at` pins the pointer
**variable's own** storage slot to `<address>` (confirmed in
`codegen_6502.cpp`'s `DeclarePointer`, which emits the pointer's zero-page
symbol as `<name> = <address>`). It does **not** make the pointer point
*at* that address: a `^byte` variable still starts out pointing nowhere
in particular and must be assigned a target with real code after
declaration, same as any other pointer on the 6502 target. Also note that
only `at` is recognized on pointer declarations; [`absolute`](absolute.md)
is not (see its own Known limitations section).
