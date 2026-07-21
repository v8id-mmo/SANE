# `@use`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE
(see Known limitations below).

Pulls a [`unit`](../keywords/unit.md) (a `.tru` file) into the current compile. The
unit's procedures, functions, and variables become reachable through a
`<UnitName>::` prefix. The compiler looks for `<name>.tru` in the current
project directory first, then in the system-specific, CPU-specific, and
global folders of the shared unit library, in that order.

## Syntax

    @use "<unit name>";
    @use <UnitName>;

Both a quoted path-like form (`@use "system/str"`, for a unit that lives
in a subfolder of the unit library) and a bare identifier form
(`@use MathHelper`, for a unit sitting next to the current file) are used
throughout the existing codebase; either is accepted.

## Parameters

- `<unit name>`: the unit's file name (without the `.tru` extension),
  optionally with a subfolder path.

## Example

```pascal
program UseDemo;
@use "mathhelper"

var
	total : byte = 0;

begin
	total := MathHelper::Double(21);
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/use.ras){ .md-button download }
(also needs [`mathhelper.tru`](../../assets/examples/mathhelper.tru), see
[`unit`](../keywords/unit.md), in the same folder)

## Known limitations

Builtins that auto-initialize themselves the first time a matching call
appears in the source text (`sine[`, `rand(`, `sqrt(`, `joystick(`, and
similar; see [`sizeof`](../keywords/sizeof.md)'s neighbors for the full builtin list)
only scan the current file's own text for that first-use pattern. A call
to one of them written only inside a `@use`d unit, with no matching call
anywhere in the main program text, doesn't trigger the auto-init, and the
builtin ends up uninitialized at runtime. Adding at least one call to the
same builtin somewhere in the main file works around it.
