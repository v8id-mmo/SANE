# `const`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a named, compile-time constant. Unlike a regular variable, a
`const` doesn't occupy any storage on the C64: every use of its name is
resolved to its literal value at compile time.

## Syntax

    var
      const <name> : <type> = <value>;

`const` declarations are written as individual lines *inside* the same
`var` block as regular variables, not as a separate top-level section.
`<type>` must be one of `address`, `byte`, `integer`, or `long`.

## Parameters

- `<name>`: the constant's identifier.
- `<type>`: `address`, `byte`, `integer`, or `long`.
- `<value>`: a constant expression.

## Example

```pascal
program ConstDemo;
var
	const maxLives : byte = 3;
	const startAddress : address = $c000;

	lives : byte = 0;

begin
	lives := maxLives;
	screen_bg_col := lives;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/const.ras){ .md-button download }
