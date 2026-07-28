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
**variable's own** storage slot to `<address>`. It does **not** make the
pointer point *at* that address: a `^byte` variable still starts out
pointing nowhere in particular and must be assigned a target with real
code after declaration, same as any other pointer on the 6502 target.

**In vanilla TRSE, only `at` is recognized on pointer declarations**;
[`absolute`](absolute.md) fails to compile there with a parse error.
:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
[`absolute`](absolute.md) is now accepted on pointer declarations too,
with the same effect as `at` (see its own Known limitations section).
