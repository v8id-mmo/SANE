# `SetCharsetAndScreenLocation`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets the character-set base address and the screen (video matrix) base
address in a single combined write, instead of two separate calls to
[`SetCharsetLocation`](setcharsetlocation.md) and a screen-location
equivalent.

## Syntax

    SetCharsetAndScreenLocation(charsetAddr : address, screenAddr : address)

## Parameters

- `charsetAddr`: a compile-time-constant address for the character set,
  one of `$0000`, `$0800`, `$1000`, `$1800`, `$2000`, `$2800`, `$3000`,
  or `$3800`, relative to the current VIC bank (see [`SetBank`](setbank.md)).
- `screenAddr`: a compile-time-constant address for the screen, a
  multiple of `$0400` within the current VIC bank (`$0000`, `$0400`,
  `$0800`, ... up to `$3C00`).

## Example

```pascal
program SetCharsetAndScreenLocationDemo;
var
	const SCRCHR1_ADR : address = $2000;
	const SCRCHR2_ADR : address = $2400;
	const FONT_ADR    : address = $2800;

	switchScreen : byte;
begin
	switchScreen := 0;
	if switchScreen > 1 then
		SetCharsetAndScreenLocation(FONT_ADR, SCRCHR2_ADR)
	else
		SetCharsetAndScreenLocation(FONT_ADR, SCRCHR1_ADR);
	clearscreen(key_space, SCRCHR1_ADR);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setcharsetandscreenlocation.ras){ .md-button download }
