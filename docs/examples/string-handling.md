# Normalizing and comparing strings

A practical pattern for text handling: converting a string's case before
comparing it, since an exact byte comparison is case-sensitive on its
own.

## What this uses

- [`StrToUpper`](../reference/builtins/strtoupper.md) /
  [`StrToLower`](../reference/builtins/strtolower.md) - convert a
  string's case in place.
- [`StrCmp`](../reference/builtins/strcmp.md) - an exact,
  case-sensitive comparison between two strings.

```pascal
program StringHandling;
var
	name : string = "Trse";
	checkName : string = "Trse";
	isMatch : boolean;

begin
	clearscreen(key_space,screen_char_loc);

	moveto(0,0,hi(screen_char_loc));
	printstring("original: ",0,40);
	moveto(10,0,hi(screen_char_loc));
	printstring(#name,0,40);

	// StrCmp is an exact, case-sensitive byte compare, so normalizing a
	// copy to uppercase first is what makes a "case-insensitive" check
	// against a known reference word possible.
	strtoupper(#checkName);
	moveto(0,1,hi(screen_char_loc));
	printstring("uppercased:",0,40);
	moveto(11,1,hi(screen_char_loc));
	printstring(#checkName,0,40);

	isMatch := strcmp(#checkName,"TRSE");
	moveto(0,2,hi(screen_char_loc));
	printstring("matches 'TRSE':",0,40);
	moveto(16,2,hi(screen_char_loc));
	printdecimal(isMatch,1);

	strtolower(#name);
	moveto(0,3,hi(screen_char_loc));
	printstring("lowercased:",0,40);
	moveto(11,3,hi(screen_char_loc));
	printstring(#name,0,40);

	loop();
end.
```

[:material-download: Download this example](../assets/examples/cookbook/string-handling.ras){ .md-button download }

## How it works

`name` and `checkName` both start out as the mixed-case text `"Trse"`.
`StrToUpper(#checkName)` converts `checkName` to `"TRSE"` in place, which
is then compared against the literal `"TRSE"` with `StrCmp`; since both
sides are now identical, byte for byte, the comparison succeeds. Without
that normalization step, comparing the original mixed-case `"Trse"`
directly against `"TRSE"` would fail, since `StrCmp` only ever checks for
an exact match and has no case-insensitive mode of its own. `name` is
left untouched by that comparison and is separately converted to
lowercase at the end with `StrToLower`, just to show the mirror-image
conversion working the other way.
