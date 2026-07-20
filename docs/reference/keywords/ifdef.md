# `@ifdef`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Compile-time conditional compilation: includes the code between `@ifdef`
and its matching `@else`/`@endif` only if the named symbol has been set
with [`@define`](define.md). Unlike [`if`](if.md), this is resolved before
compilation starts, so the excluded branch's code doesn't exist in the
compiled program at all, not even as dead code.

## Syntax

    @ifdef <name>
        <code, only compiled if <name> was @defined>
    @endif

@ifdef with @else brach:

    @ifdef <name>
        <code, only compiled if <name> was @defined>
    @else
        <code, only compiled otherwise>
    @endif

## Parameters

- `<name>`: the symbol to check, as previously set with `@define <name>
  <value>;` (or left absent entirely).

## Example

```pascal
program IfdefDemo;

@ifdef target_ntsc
var
	refreshRate : byte = 60;
@else
var
	refreshRate : byte = 50;
@endif

begin
	screen_bg_col := refreshRate;
	loop();
end.
```

Since `target_ntsc` is never `@define`d in this file, the `@else` branch
is the one actually compiled in.

[:material-download: Download this example](../../assets/examples/ifdef.ras){ .md-button download }

## See also

[`@ifndef`](ifndef.md) is the inverted form (compiles the block when the
symbol is **not** defined). There's also a separate `@if <name> = <value>`
form that checks a defined symbol against a specific value rather than
just checking whether it exists; see [`if`](if.md).
