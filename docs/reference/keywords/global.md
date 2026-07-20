# `global`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A parameter-declaration flag that binds a procedure/function parameter
directly to an existing global variable of the same name, instead of
giving the parameter its own private storage. A call passing a value for a
`global` parameter compiles down to a plain assignment into that global
variable, followed by the call, with no parameter-passing overhead at all.

## Syntax

    procedure <name>(<param> : global <type>);

A global variable named exactly `<param>` must already be declared (in the
top-level `var` block) before the procedure is declared; compilation fails
with a clear error otherwise.

## Example

```pascal
program GlobalDemo;

var
	c : byte;

procedure SetColor(c : global byte);
begin
	screen_bg_col := c;
end;

begin
	SetColor(black);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/global.ras){ .md-button download }

## Known limitations

Because a `global` parameter is really just the one shared variable
underneath, it isn't safe for recursion or reentrancy: if the procedure
calls itself (directly or indirectly), or gets interrupted by an IRQ
handler that calls it again, the second call's argument overwrites the
first call's, since there's only ever one storage location involved. This
is an inherent trade-off of what the flag does (skip parameter-passing
entirely for speed/size), not an accidental bug, but it's easy to reach
for on instinct without realizing the shared-storage consequence.
