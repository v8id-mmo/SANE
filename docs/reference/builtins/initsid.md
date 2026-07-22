# `InitSid`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Calls a SID tune's own init routine (the standard entry point every SID
file exposes for selecting a subtune and setting up its player), passing
subtune `0`. Unlike the `init...` routines paired with an auto-init
trigger, `InitSid` is always called explicitly by the program; it isn't
part of the automatic-initialization scan mechanism.

## Syntax

    InitSid( <address> );

## Parameters

- `<address>`: the SID init entry point to call. Must be a compile-time
  constant, typically the `_init` label an `incsid`-declared variable
  generates (see the example below).

## Example

```pascal
program InitSidDemo;

var
	sidfile : incsid("courier.sid", 2);

begin
	InitSid(sidfile_1_init);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/initsid.ras){ .md-button download }
(also needs [`courier.sid`](../../assets/examples/courier.sid) in the
same folder)

## Known limitations

`<address>` must be a compile-time constant; passing a variable or any
other non-constant expression fails to compile with "InitSid currently
only supports constant values."
