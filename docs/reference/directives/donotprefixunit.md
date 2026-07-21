# `@donotprefixunit`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Disables automatic name-prefixing for an entire unit (`.tru`). Normally,
compiling a unit prefixes every symbol it declares with the unit's own
name (so `HelperUnit`'s `myVar` becomes `HelperUnit_myVar` internally);
this directive turns that off for the whole file. See [`@donotprefix`](donotprefix.md)
for the single-symbol version.

## Syntax

    @donotprefixunit;

Takes no argument; place it once, anywhere in the unit file.

## Example

```pascal
program DoNotPrefixUnitCheck;

@donotprefixunit

var
	i : byte = 0;

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/donotprefixunit.ras){ .md-button download }
