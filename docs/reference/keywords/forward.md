# `forward`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Declares a procedure or function's signature without its body, so it can
be called before its real implementation appears later in the file. Used
for mutual recursion, or simply to control the order procedures are
defined in without worrying about "used before declared" errors.

## Syntax

    procedure <name>(<params>); forward;

    // ... later in the same file ...

    procedure <name>(<params>);
    begin
        <statements>;
    end;

The real definition that follows must repeat the same parameter list.

## Example

```pascal
program ForwardDemo;

procedure Ping(); forward;

procedure Pong();
begin
	Ping();
end;

procedure Ping();
begin
	screen_bg_col := black;
end;

begin
	Pong();
	loop();
end.
```

`Pong` calls `Ping` before `Ping`'s real body is defined further down the
file; the `forward` declaration above makes that legal.

[:material-download: Download this example](../../assets/examples/forward.ras){ .md-button download }
