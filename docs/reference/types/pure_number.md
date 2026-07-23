# `pure_number`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A parameter modifier, not a storage type: restricts a procedure/function
parameter to a compile-time constant number, rejecting both computed
expressions and plain variable references. The narrower of
[`pure`](pure.md)'s two variants (see also [`pure_variable`](pure_variable.md)
for the opposite restriction); mostly used in unit-authoring to pick
between multiple overloads of the same procedure depending on whether the
caller passed a literal or a variable.

## Syntax

    procedure <name>(<param> : <type> pure_number) inline;
    begin
        ...
    end;

## Parameters

- `<param>`: the parameter this flag applies to.
- `<type>`: the parameter's underlying type (`byte`, `integer`, etc.);
  `pure_number` is written right after it.

## Example

```pascal
program PureNumberDemo;

procedure SetLevel(v : byte pure_number) inline;
begin
	screen_bg_col := v;
end;

begin
	SetLevel(3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pure_number.ras){ .md-button download }

## Known limitations

**Passing a variable instead of a constant fails to compile**, rather
than being silently accepted: calling the `SetLevel` procedure above with
a variable (`SetLevel(level);`) fails with "Procedure 'SetLevel' requires
parameter 0 to be a pure number / constant." Use [`pure_variable`](pure_variable.md)
instead if the parameter should only ever accept a variable, or
[`pure`](pure.md) to accept either.
