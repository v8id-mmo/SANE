# `SetCharsetLocation`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets the character-set base address the VIC-II reads text-mode
characters from. In bitmap mode, the same register also selects the
bitmap data's base address, so this builtin is used for both purposes.

## Syntax

    SetCharsetLocation(addr : address)

## Parameters

- `addr`: a compile-time-constant address, one of `$0000`, `$0800`,
  `$1000`, `$1800`, `$2000`, `$2800`, `$3000`, or `$3800`, relative to
  the current VIC bank (see [`SetBank`](setbank.md)).

## Example

```pascal
program SetCharsetLocationDemo;
var
	const charsetLoc : address = $2000;
begin
	setcharsetlocation(charsetLoc);
	clearscreen(key_space, screen_char_loc);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setcharsetlocation.ras){ .md-button download }
