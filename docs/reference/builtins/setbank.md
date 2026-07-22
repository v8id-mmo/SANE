# `SetBank`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Selects which 16KB region of memory the VIC-II chip reads its video data
from (screen, charset, and bitmap/sprite data), out of the full 64KB
address space.

## Syntax

    SetBank(bank : byte)

## Parameters

- `bank`: normally one of the shipped constants `VIC_BANK0` ($0000-$3FFF),
  `VIC_BANK1` ($4000-$7FFF), `VIC_BANK2` ($8000-$BFFF), or `VIC_BANK3`
  ($C000-$FFFF).

## Example

```pascal
program SetBankDemo;
begin
	SetBank(vic_bank1);   // VIC now reads from $4000-$7FFF
	SetCharsetLocation($6000);
	clearscreen(key_space, screen_char_loc);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setbank.ras){ .md-button download }

## Known limitations

`SetBank` writes its value straight to the CIA register that controls
the VIC bank, without preserving that register's other bits. Those other
bits also carry the serial (IEC) bus and RS-232 output lines, so every
call to `SetBank` forces them low as a side effect. This is harmless for
almost all programs, since disk/tape activity has normally already
finished by the time `SetBank` gets called, but it's worth knowing about
if you're writing custom fastloader or serial-bus code and might call
`SetBank` while a transfer is still active.
