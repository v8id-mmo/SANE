# `var`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Opens a block of variable declarations. Every program, procedure,
function, and unit that declares any variables (or [`const`](const.md)/
[`type`](type.md) entries) starts one with `var`.

## Syntax

    var
      <name> : <type>;
      <name> : <type> = <initial value>;
      <name1>, <name2>, ... : <type>;

## Parameters

- `<name>`: the variable's identifier.
- `<type>`: a built-in type (`byte`, `integer`, `long`, `boolean`,
  `pointer`, `array[...] of ...`, `string`, ...) or a name introduced by
  [`type`](type.md).
- `<initial value>`: optional; sets the variable's value at program start.
  Several comma-separated names can share one type/declaration line.

A `var` block declared at the top of a `program` (or `unit`) is global,
visible everywhere after it. A `var` block declared inside a
[`procedure`](procedure.md)/`function` is local to that procedure/function
instead.

## Example

```pascal
program VarDemo;

var
	score : byte = 0;
	lives, hitPoints : byte;
	highScore : integer = 1000;

begin
	lives := 3;
	hitPoints := 100;
	score := score + 1;
	screen_bg_col := score;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/var.ras){ .md-button download }
