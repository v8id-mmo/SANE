# `@userdata`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reserves a fixed address range so the compiler's automatic memory
allocator never places a variable or generated code inside it. Useful for
protecting a block of memory that something outside the compiled program
(a loader, a fixed-address asset, hand-placed data) needs to own.

## Syntax

    @userdata "<from address>" "<to address>" "<name>";

## Parameters

- `<from address>`, `<to address>`: the reserved range, as quoted
  hexadecimal strings (e.g. `"$c000"`).
- `<name>`: a label for the reservation, purely descriptive.

## Example

```pascal
program UserDataDemo;

@userdata "$c000" "$c100" "Reserved data block"

var
	total : byte = 0;

begin
	total := total + 1;
	screen_bg_col := total;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/userdata.ras){ .md-button download }
