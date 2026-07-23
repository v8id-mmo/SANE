# `StrToLower`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Converts every uppercase ASCII letter in a zero-terminated string to
lowercase, in place.

## Syntax

    StrToLower( <text> );

## Parameters

- `<text>`: a `string` variable (passed with `#`) or a `pointer` already
  holding a string's address. Only bytes in the `A`-`Z` range are
  changed; every other byte (digits, punctuation, already-lowercase
  letters) is left untouched.

## Example

```pascal
program StrToLowerDemo;
var
	text : string = "HELLO WORLD";
begin
	clearscreen(key_space,screen_char_loc);
	moveto(0,0,hi(screen_char_loc));
	printstring(#text,0,40); // "HELLO WORLD"

	strtolower(#text);
	moveto(0,1,hi(screen_char_loc));
	printstring(#text,0,40); // "hello world"

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/strtolower.ras){ .md-button download }
