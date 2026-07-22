# `RightBitShift`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Shifts a strip of 8-row character/bitmap data, `num` bytes wide, one bit
to the right. Each of the 8 rows is shifted independently across the
`num` bytes that make up that row (see Known limitations for what
actually happens to the outgoing bit). [`LeftBitShift`](leftbitshift.md)
is the mirror version, shifting to the left; both share the exact same
underlying implementation and the same behavior described there.

## Syntax

    RightBitShift( <address>, <num> )

## Parameters

- `<address>`: the start of the data. The 8 rows of the first byte-wide
  column live at `<address>`, `<address>+1`, ... `<address>+7`; the next
  column starts 8 bytes later, and so on.
- `<num>`: how many byte-wide columns make up the strip.

## Example

```pascal
program RightBitShiftDemo;
var
	// one 8x8 custom character, one bit set per row
	shape : array[8] of byte = ($80, $80, $80, $80, $80, $80, $80, $80);
	value : byte;
begin
	clearscreen(key_space,screen_char_loc);
	rightbitshift(#shape,1);
	value := shape[0];
	moveto(0,0,hi(screen_char_loc));
	printdecimal(value,3);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/rightbitshift.ras){ .md-button download }

## Known limitations

Despite the name, this is a rotate, not a shift: the bit that falls off
one end of the `num`-byte-wide strip is never dropped, it reappears at
the opposite end. That's true even at the simplest width (`num=1`, a
single byte-wide column): each row's own outgoing bit becomes its own
incoming bit. There's no way to get a true shift (vacated bit filled
with `0`, outgoing bit discarded) through this builtin. `LeftBitShift`
shares the same underlying routine and the same behavior.
