# `@use`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE's
`sine[]` auto-init only triggered off usages in the currently-compiled
file's own text, missing a usage that only appeared inside a `@use`d
unit; SANE also picks up a unit-only usage.

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

**In vanilla TRSE, builtins that auto-initialize themselves the first
time a matching call appears in the source text (`sine[`, `rand(`,
`sqrt(`, `joystick(`, and similar) only scan the current file's own text
for that first-use pattern, so a call written only inside a `@use`d unit,
with no matching call anywhere in the main program text, can fail to
trigger the auto-init.** In practice, `sine[]` is the only one of these
confirmed to actually misbehave this way (silently returning `0` from
every read, since its table-fill routine never runs); the others either
check for the missing setup at compile time and fail loudly instead, or
don't need a separate setup step to begin with. On vanilla TRSE, adding
at least one real, uncommented `sine[...]` call somewhere in the main
file works around it for `sine[]`.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
a unit's own resolved auto-init triggers are now merged back into the
compiled program's, so a call written only inside a `@use`d unit
correctly triggers the auto-init and the workaround is no longer
necessary.
