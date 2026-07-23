# `pure_variable`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A parameter modifier, not a storage type: restricts a procedure/function
parameter to a plain variable reference, rejecting both computed
expressions and literal constants. The opposite restriction from
[`pure_number`](pure_number.md) (see also [`pure`](pure.md) for the
either/or version); mostly used in unit-authoring to pick between
multiple overloads of the same procedure depending on whether the caller
passed a variable or a literal.

## Syntax

    procedure <name>(<param> : <type> pure_variable) inline;
    begin
        ...
    end;

## Parameters

- `<param>`: the parameter this flag applies to.
- `<type>`: the parameter's underlying type (`byte`, `integer`, etc.);
  `pure_variable` is written right after it.

## Example

```pascal
program PureVariableDemo;
var
	level : byte = 5;

procedure SetLevel(v : byte pure_variable) inline;
begin
	screen_bg_col := v;
end;

begin
	SetLevel(level);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pure_variable.ras){ .md-button download }

## Known limitations

**Passing a literal instead of a variable fails to compile**, rather than
being silently accepted: calling the `SetLevel` procedure above with a
constant (`SetLevel(3);`) fails with "Procedure 'SetLevel' requires
parameter 0 to be a pure variable." Use [`pure_number`](pure_number.md)
instead if the parameter should only ever accept a constant, or
[`pure`](pure.md) to accept either.
