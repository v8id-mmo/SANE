# `@donotremove`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Tells the compiler's unused-symbol removal pass to keep a symbol even if
nothing in the visible TRSE source appears to reference it. Useful for a
variable or label that's only ever referenced from inside a raw
[`asm`](asm.md) block, which the compiler can't statically see as a use.

## Syntax

    @donotremove <symbolName>;

## Parameters

- `<symbolName>`: the identifier to protect from removal.

## Example

```pascal
program DoNotRemoveDemo;

@donotremove unusedHelper

var
	unusedHelper : byte = 0;

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/donotremove.ras){ .md-button download }
