# `@define`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Defines a compile-time text substitution: every later occurrence of
`@<name>` in the source is replaced with `<value>`, verbatim, before
parsing continues. Also usable as a flag for `@ifdef`/`@ifndef` conditional compilation,
since those just check whether a given name was defined at all.

## Syntax

    @define <name> <value>;

## Parameters

- `<name>`: the identifier that `@<name>` will be replaced with `<value>`
  wherever it's referenced later in the source.
- `<value>`: the raw text to substitute in. Not limited to numbers: any
  token sequence works, since the substitution happens on the raw source
  text before tokenizing.

## Example

```pascal
program DefineDemo;

@define borderColorValue 6

var
	i : byte = 0;

begin
	screen_bg_col := @borderColorValue;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/define.ras){ .md-button download }
