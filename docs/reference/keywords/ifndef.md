# `@ifndef`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

The inverted form of [`@ifdef`](ifdef.md): includes the code between
`@ifndef` and its matching `@else`/`@endif` only if the named symbol has
**not** been set with [`@define`](define.md).

## Syntax

    @ifndef <name>
        <code, only compiled if <name> was NOT @defined>
    @endif

    @ifndef <name>
        <code, only compiled if <name> was NOT @defined>
    @else
        <code, only compiled if it WAS @defined>
    @endif

## Parameters

- `<name>`: the symbol to check.

## Example

```pascal
program IfndefDemo;

@ifndef skip_greeting
var
	greeted : byte = 1;
@endif

begin
	screen_bg_col := greeted;
	loop();
end.
```

`skip_greeting` is never `@define`d here, so the guarded block is compiled
in.

[:material-download: Download this example](../../assets/examples/ifndef.ras){ .md-button download }
