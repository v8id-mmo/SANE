# `integer`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
only implemented `<`/`<=` for signed `integer` comparisons; SANE
implements all six comparison operators.

A 16-bit value, `0` to `65535` unsigned, or `-32768` to `32767` with
[`signed`](../keywords/signed.md). The general-purpose "word-sized" numeric
type on the C64 target; there is no separately-spelled `word` type in this
fork, `integer` is the only 16-bit type.

## Syntax

    var
        <name> : integer;
        <name> : integer = <initial value>;
        <name> : signed integer;

## Parameters

- `<name>`: the variable's identifier.
- `<initial value>`: optional, `0`-`65535` (or `-32768`-`32767` for
  `signed integer`).

## Example

```pascal
program IntegerDemo;
var
	score : integer = 1000;
	delta : integer = -250;
	sscore : signed integer = -1;
	total : integer;
begin
	clearscreen(key_space,screen_char_loc);

	total := score + delta;
	moveto(0,0,hi(screen_char_loc));
	printstring("total:",0,40);
	moveto(7,0,hi(screen_char_loc));
	printdecimal(total,4);

	// On vanilla TRSE, only < and <= were implemented for signed integer
	// comparison (known limitation, see below); SANE implements all six.
	moveto(0,1,hi(screen_char_loc));
	if (sscore < 0) then
		printstring("sscore is negative",0,40);

	loop();
end.
```

[:material-download: Download this example](../../assets/examples/integer.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, signed comparison is incomplete.** For a `signed
integer`, only `<` and `<=` are implemented; every other comparison
operator (`>`, `>=`, `=`, `<>`) fails to compile with "Signed integer
comparison: only 'less' is currently implemented." :material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
all six comparison operators now work on `signed integer`. See
[`signed`](../keywords/signed.md)'s Known limitations for the full
cluster of related signed-arithmetic gaps, some of which are still open,
that apply to `signed integer`.
