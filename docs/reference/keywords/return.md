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

## Known limitations

`return;` always exits the same way a procedure normally falls off its
own `end;`, regardless of what kind of procedure it's used in. Inside an
`interrupt` procedure specifically, that's the wrong exit: `return;` used
partway through an interrupt handler's body leaves the interrupt without
properly restoring processor state on the way out, unlike reaching the
handler's own `end;` naturally, which does it correctly. Use
[`ReturnInterrupt`](../builtins/returninterrupt.md) instead of `return;`
for an early exit from inside an `interrupt` procedure.
