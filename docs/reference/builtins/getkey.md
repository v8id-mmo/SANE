# `getKey`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reads the keyboard matrix directly (not through the KERNAL) and returns a
raw key code, or `0` if no key is currently pressed.

## Syntax

    <byte> = getkey()

## Returns

A raw keyboard-matrix scan code for whichever key is currently held down,
or `0` if none is.

## Example

```pascal
program GetKeyDemo;
var
	key : byte = 0;
begin
	clearscreen(key_space,screen_char_loc);
	repeat
		key := getkey();
	until key<>0;
	screen_bg_col := LIGHT_GREEN;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/getkey.ras){ .md-button download }

## Known limitations

The compiler internally flags `getKey` as scheduled for deprecation in
favor of a newer input-handling unit, but that notice (like every other
compiler warning issued through the command-line build) never actually
reaches the terminal or the compiled output. `getKey` compiles and runs
exactly the same either way; only its long-term future is in question,
not its current behavior.
