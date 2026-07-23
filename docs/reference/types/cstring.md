# `cstring`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A text literal stored as C64 screen codes instead of PETSCII/ASCII text.
Every character is converted at compile time into the byte value the VIC-II
expects in screen memory, so a `cstring` can be copied straight into screen
memory (or color memory, or anywhere else screen codes are needed) with no
runtime conversion step. Use plain [`string`](string.md) instead for text
that's printed through [`printstring`](../builtins/printstring.md)/
[`Tile`](../builtins/tile.md) or passed to a KERNAL-style routine that
expects PETSCII.

## Syntax

    var
        <name> : cstring = "<text>";
        <name> : cstring = ("<part1>", "<part2>", ...);
        <name> : cstring invert = "<text>";
        <name> : cstring = ("<text>") no_term;

## Parameters

- `<name>`: the variable's identifier.
- `"<text>"`: one string literal, or several concatenated together as a
  comma-separated list in parentheses.
- [`invert`](../keywords/invert.md): optional flag, ORs `$80` into every
  character's screen code (reverse video), `cstring`-only.
- [`no_term`](../keywords/no_term.md): optional flag, suppresses the
  trailing terminator byte normally appended after the data.

## Example

```pascal
program CstringDemo;
var
	greeting : cstring = "HELLO WORLD";
	i : byte;
begin
	clearscreen(key_space,screen_char_loc);

	// cstring text is pre-converted to screen codes at compile time,
	// so it can be copied straight into screen memory with no runtime
	// conversion needed, unlike a plain string
	for i:=0 to 10 do
		poke(screen_char_loc, i, greeting[i]);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/cstring.ras){ .md-button download }
