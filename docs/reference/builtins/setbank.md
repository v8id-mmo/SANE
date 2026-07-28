# `SetBank`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla TRSE
wrote this register unmasked, clobbering the serial IEC bus and RS-232
output bits on every call; SANE does a masked read-modify-write instead.

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

**In vanilla TRSE, `SetBank` writes its value straight to the CIA
register that controls the VIC bank, without preserving that register's
other bits.** Those other bits also carry the serial (IEC) bus and
RS-232 output lines, so every call to `SetBank` on vanilla TRSE forces
them low as a side effect. This is harmless for almost all programs,
since disk/tape activity has normally already finished by the time
`SetBank` gets called, but it's worth knowing about if you're writing
custom fastloader or serial-bus code and might call `SetBank` while a
transfer is still active.

:material-check-decagram:
**[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
`SetBank` now does a masked read-modify-write, preserving the register's
other bits. It depends on the compiling project's `temp_zeropages`
setting being non-empty, the same as
[`ScrollX`](scrollx.md)/[`ScrollY`](scrolly.md); every shipped project
template already populates this.
