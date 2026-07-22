# `SetScreenLocation`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets the base address of screen (character) memory within the currently
selected 16KB VIC-II bank (see [`SetBank`](setbank.md)). Only certain
offsets within the bank are valid; the compiler rejects anything else at
compile time.

## Syntax

    SetScreenLocation(address : address)

## Parameters

- `address`: a compile-time constant address at one of the legal
  `$X000`-`$XC00` offsets within the current 16KB VIC bank. Anything else
  is a compile error.

## Example

```pascal
program SetScreenLocationDemo;
begin
	SetScreenLocation($0800);   // move screen memory to $0800 (within VIC bank 0)
	clearscreen(key_space, $0800);
	moveto(0,0,hi($0800));
	printstring("screen moved to $0800",0,40);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/setscreenlocation.ras){ .md-button download }

## Known limitations

The sprite-pointer table's location always follows the *default* screen
address, not wherever `SetScreenLocation` actually moves it to. If you
relocate the screen with `SetScreenLocation` and also use sprites, see
[`SetSpriteLoc`](setspriteloc.md)'s Known limitations for the resulting
gotcha.
