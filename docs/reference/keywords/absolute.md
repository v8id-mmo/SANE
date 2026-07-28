# `absolute`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE only accepts `absolute` on plain variable declarations, silently
rejecting it on a pointer declaration with a parse error; SANE accepts
`absolute` on pointer declarations too, matching `at`.

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

**In vanilla TRSE, `absolute` is accepted for plain byte/word/array/string
variable declarations, but not for pointer declarations**
(`^byte`/`^integer` at a fixed address): `^byte absolute $9000;` fails to
compile there, even though `^byte at $9000;` works fine.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`absolute` is now accepted on pointer declarations too, with the same
effect as `at`.
