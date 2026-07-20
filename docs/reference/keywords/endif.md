# `@endif`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Closes an `@ifdef`/`@ifndef` conditional-compilation block. Everything
between the `@ifdef`/`@ifndef` and its matching `@endif` is only included
in the compiled program if the condition holds.

## Syntax

    @ifdef <name>
      <code, only compiled if <name> was @defined>
    @endif

## Example

```pascal
program EndIfDemo;

@define usemsg 1

var
	i : byte = 0;

begin
@ifdef usemsg
	i := 1;
@endif
	screen_bg_col := i;
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/endif.ras){ .md-button download }
