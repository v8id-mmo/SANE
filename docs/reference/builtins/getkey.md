# `getKey`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
never surfaces the deprecation warning below when compiling from the
command line; SANE fixes this, see Known limitations below.

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
favor of a newer input-handling unit. `getKey` compiles and runs exactly
the same either way; only its long-term future is in question, not its
current behavior.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
that notice (like every other compiler warning issued through the
command-line build) used to never reach the terminal or the compiled
output; a successful CLI compile now prints every queued warning at the
end of the compile, so calling `getKey` does now show the deprecation
notice.
