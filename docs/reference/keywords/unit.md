# `unit`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a `.tru` file as a reusable unit: a separate source file of
variables, procedures, and functions that a program (or another unit)
pulls in with [`@use`](../directives/use.md). It plays the same role as `program` does
for a `.ras` file, just for a file that isn't compiled on its own.

## Syntax

    unit <name>;

    var
      <declarations>

    <procedure/function declarations>

    end.

A unit file needs a `var` block even if it declares no variables in it;
leaving it out entirely fails to compile with `TRUs must contain at least
one "var" declaration block`. The whole file still ends with `end.`, the
same as a `program` block.

## Parameters

- `<name>`: the unit's identifier. This becomes the prefix (`<name>::`)
  used to reach the unit's procedures/functions/variables from wherever
  it's `@use`d, and the filename it's looked up by (`<name>.tru`).

## Example

```pascal
unit MathHelper;

var

function Double(x : byte) : byte;
begin
	Double := x * 2;
end;

end.
```

[:material-download: Download this example](../../assets/examples/mathhelper.tru){ .md-button download }
(a unit file isn't compiled on its own; see [`@use`](../directives/use.md) for a
driver program that pulls this one in and calls `MathHelper::Double`)
