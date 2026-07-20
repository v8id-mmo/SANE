# `no_term`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A flag on a `string`/`cstring` declaration that suppresses the automatic
terminator byte normally appended after the text data. Useful for building
a raw, fixed-width lookup table out of character data instead of a
null-terminated string.

## Syntax

    name : cstring = ( "a", "b", ... ) no_term;
    name : no_term string[<size>];

`no_term` can appear either right after the initializer or right before
the type, both are accepted.

## Parameters

None; it's a bare flag, not a value-taking keyword.

## Example

```pascal
program NoTermDemo;
var
	rawBytes : cstring = ("A","B","C") no_term;
	i : byte;

begin
	for i := 0 to 2 do
	begin
		screen_bg_col := rawBytes[i];
	end;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/no_term.ras){ .md-button download }

## Known limitations

**Only legal on `string`/`cstring` declarations.** Using `no_term` on any
other type is a compile-time error, not a silent no-op.
