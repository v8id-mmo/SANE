# `procedure`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a named, callable block of statements, Pascal-style. A procedure
compiles down to a real subroutine call (jump to a label, run the body,
jump back), not inlined text, unless it's separately marked
[`inline`](inline.md).

## Syntax

    procedure <name>(<params>);
    begin
        <statements>;
    end;

    procedure <name>(<params>); forward;   // declare signature only
    procedure <name>(<params>); assembler; // body is raw assembler, no begin/end

A [`function`](function.md) is the same thing with a return value: add
`: <returnType>` after the parameter list.

## Parameters

- `<name>`: the procedure's name, used to call it later.
- `<params>`: a comma-separated list of `name : type` pairs. Each
  parameter can optionally carry a flag before its type:
    - plain (no flag): the argument is copied into the parameter's own
      storage before the call, ordinary by-value semantics.
    - [`global`](global.md): the parameter aliases an existing global
      variable of the same name instead of getting its own storage.
    - [`stack`](stack.md): the parameter lives on a real runtime stack (pushed before
      the call, popped after) instead of a fixed memory address. Only
      `byte` parameters are currently allowed with this flag.

## Example

```pascal
program ProcedureDemo;

procedure SetBorder(c : byte);
begin
	screen_bg_col := c;
end;

begin
	SetBorder(black);
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/procedure.ras){ .md-button download }

## Known limitations

A plain procedure call like the one above always evaluates each argument
exactly once, right before the call, so passing something more complex
than a bare variable or literal is completely safe here. That is not true
for a procedure marked `inline`: an inline procedure's parameters are
substituted as raw expression text at every place they're referenced
inside the body, so a complex argument referenced more than once can be
re-evaluated multiple times. See [`inline`](inline.md)'s Known limitations
for the full explanation and a workaround; it does not apply to ordinary,
non-inline procedures like the one on this page.
