# `pure`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A parameter modifier, not a storage type: it restricts what kind of
argument a procedure/function parameter accepts, rather than describing
how a value is stored. A `pure` parameter must be either a compile-time
constant number or a plain variable reference, not a computed expression.
Mostly used in unit-authoring (see the `units/` library's own procedures,
e.g. `Poke`/`RasterIRQ`) to pick between multiple overloads of the same
procedure at compile time, but usable in any procedure/function
declaration.

## Syntax

    procedure <name>(<param> : <type> pure) inline;
    begin
        ...
    end;

## Parameters

- `<param>`: the parameter this flag applies to.
- `<type>`: the parameter's underlying type (`byte`, `integer`, etc.);
  `pure` is written right after it.

## Example

```pascal
program PureDemo;
var
	level : byte = 5;

procedure SetLevel(v : byte pure) inline;
begin
	screen_bg_col := v;
end;

begin
	SetLevel(3);      // a constant number is accepted
	SetLevel(level);  // a plain variable is accepted too
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/pure.ras){ .md-button download }

## Known limitations

**Passing anything more complex than a constant or a plain variable
fails to compile**, rather than being silently accepted: calling the
`SetLevel` procedure above with an expression (`SetLevel(level+1);`) fails
with "Procedure 'SetLevel' requires parameter 0 to be a pure variable or
number." See [`pure_number`](pure_number.md) and
[`pure_variable`](pure_variable.md) for the two narrower variants of this
same restriction.
