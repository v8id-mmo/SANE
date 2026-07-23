# `StrCmp`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Compares two zero-terminated strings for exact equality.

## Syntax

    <boolean> = StrCmp( <a>, <b> )

## Parameters

- `<a>`: a `string`/array variable (passed with `#`), a `pointer`, or a
  double-quoted string literal.
- `<b>`: same set of options as `<a>`. `<a>` and `<b>` don't need to be
  the same kind (a variable can be compared directly against a literal,
  as in the example below).

## Returns

`true` if both strings have identical bytes up to and including their
zero terminator, `false` otherwise (including when one string is a
prefix of the other).

## Example

```pascal
program StrCmpDemo;
var
	name : string = "TRSE";
	match : boolean;
begin
	clearscreen(key_space,screen_char_loc);

	match := strcmp(#name,"TRSE");
	moveto(0,0,hi(screen_char_loc));
	printdecimal(match,1); // 1: equal

	match := strcmp(#name,"SANE");
	moveto(0,1,hi(screen_char_loc));
	printdecimal(match,1); // 0: not equal

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/strcmp.ras){ .md-button download }
