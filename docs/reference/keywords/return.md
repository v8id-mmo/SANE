# `return`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Exits the current procedure or function immediately, skipping any
remaining statements in it. Works the same way as
[`break`](break.md)/[`continue`](continue.md) do for loops, except it
exits the whole procedure rather than just a loop iteration.

## Syntax

    return;

Takes no value and no parentheses; a plain `return;` is enough, and an
optional empty `return();` is also accepted.

## Example

```pascal
program ReturnDemo;
var
	value : byte;

procedure CheckValue(v : byte);
begin
	if (v = 0) then begin
		screen_bg_col := black;
		return;
	end;
	screen_bg_col := white;
end;

begin
	value := 0;
	CheckValue(value);
	loop();
end.
```

`CheckValue` returns early as soon as it sets the border black, so the
`screen_bg_col := white` line below never runs for a zero value.

[:material-download: Download this example](../../assets/examples/return.ras){ .md-button download }
