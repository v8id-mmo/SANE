# `inline`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

A procedure/function modifier requesting that every call site have the
body's code inserted directly in place, instead of a real `jsr`/`rts` call.
Parameters are passed by direct text/expression substitution rather than
being copied into local variables first (see Known limitations for what
that means in practice).

## Syntax

    procedure <name>(<params>) inline;
    begin
      ...
    end;

## Parameters

None beyond the procedure's own declaration; `inline` itself takes no
argument. It goes right after the closing `)` of the parameter list (and
before a function's `: <returnType>`, if any), not after the trailing
semicolon.

## Example

```pascal
program InlineDemo;

procedure SetBorder(c : byte) inline;
begin
	screen_bg_col := c;
end;

begin
	SetBorder(6);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/inline.ras){ .md-button download }

## Known limitations

**Passing anything more complex than a plain variable or a numeric
literal as a parameter to an `inline` procedure isn't reliable if the
parameter is referenced more than once inside the procedure body.** An
`inline` procedure doesn't evaluate its parameters once and store the
result; instead, the parameter expression's own text gets substituted in
at every place the parameter is referenced inside the body. For a simple
parameter (a bare variable name, a literal number) this is harmless, since
that text is always safe to drop in anywhere. But for a more complex
parameter (an array index, a pointer dereference, a computed expression),
referencing the parameter more than once inside the body re-evaluates the
whole expression each time, which can duplicate side effects or produce a
different result than expected. Inside a raw `asm(...)` block specifically,
the substituted text may not even be valid as a standalone operand for the
complex-expression case.

**Workaround:** if you need to pass something more complex than a bare
variable or literal to an `inline` procedure, copy it into a local temp
variable first and pass that instead:

```pascal
tmp := someArray[complexIndex];
SetBorder(tmp);
```

This only affects procedures marked `inline`; regular procedure calls
are unaffected.
