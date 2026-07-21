# `@ignoremethod`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Opts a named builtin out of TRSE's automatic initialization scan. Several
builtins (`sine[`, `rand(`, `sqrt(`, `joystick(`, and others) normally get
an automatic `jsr init...` call inserted at program start the first time
the compiler spots that pattern anywhere in the source text. `@ignoremethod`
suppresses that automatic insertion for the named builtin, for programs
that want to call the matching `init...` routine manually instead (for
example, to control exactly when it runs).

## Syntax

    @ignoremethod <builtinName>

## Parameters

- `<builtinName>`: the builtin to exclude from auto-initialization (for
  example, `sine` to stop `sine[...]` usages from auto-inserting a call to
  `initsinetable`).

## Example

```pascal
program IgnoreMethodDemo;

@ignoremethod unusedHelper

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/ignoremethod.ras){ .md-button download }
