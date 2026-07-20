# `until`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Pairs with [`repeat`](repeat.md) to close a post-condition loop: the
condition after `until` is checked after each pass through the body, and
the loop keeps running while it's false, exiting the moment it becomes
true. Used nowhere else in the language.

## Syntax

    repeat
        <statements>
    until <condition>;

## Example

```pascal
program UntilDemo;
var
	i : byte = 0;

begin
	repeat
		i := i + 1;
	until (i = 5);
	screen_bg_col := i;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/until.ras){ .md-button download }

## Known limitations

`onpage`/`offpage` cannot be applied to a `repeat...until` loop at all,
even though the code generator has full working support for both
directions here; writing either keyword on a `repeat...until` loop
desyncs the parser instead of applying the override. See
[`onpage`](onpage.md)'s Known limitations for the full explanation.
