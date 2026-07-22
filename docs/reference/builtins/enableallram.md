# `EnableAllRam`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Switches the C64's memory configuration so BASIC ROM ($A000-$BFFF) and
KERNAL ROM ($E000-$FFFF) are both replaced by plain RAM. The I/O area at
$D000-$DFFF (VIC-II, SID, CIA registers, and color RAM) is left exactly
as it was, still visible, not replaced by RAM or character ROM. This is
the usual setup for code or data that needs to occupy the space normally
taken by BASIC/KERNAL, while still being able to talk to the VIC-II/SID
and update the screen.

## Syntax

    EnableAllRam();

## Parameters

None.

## Example

```pascal
program EnableAllRamDemo;
var
	source : array[10] of byte = (1,2,3,4,5,6,7,8,9,10);
	dest : pointer at $A000;

begin
	// Banks out BASIC/KERNAL ROM so $A000-$BFFF and $E000-$FFFF can be
	// used as plain RAM; VIC/SID/CIA/color RAM at $D000-$DFFF stay visible.
	EnableAllRam();
	memcpy(#source,0,dest,10);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/enableallram.ras){ .md-button download }
