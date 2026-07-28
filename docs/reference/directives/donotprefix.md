# `@donotprefix`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE fails to compile this directive in any configuration; SANE fixes
the underlying token-consumption bug so it now compiles and works as
intended.

Intended to disable automatic unit-name prefixing for a single named
symbol (a more targeted version of [`@donotprefixunit`](donotprefixunit.md),
which disables it for the whole unit).

## Syntax

    @donotprefix <symbolName>;

## Parameters

- `<symbolName>`: the identifier to exempt from prefixing.

## Example

```pascal
program DoNotPrefixCheck;

@donotprefix i

var
	i : byte = 0;

begin
	loop();
end.
```

[:material-download: Download this example](../../assets/examples/donotprefix.ras){ .md-button download }

## Known limitations

**In vanilla TRSE, this directive does not compile, in any
configuration.** It fails both as a plain top-level directive in a `.ras`
main program, and inside a `.tru` unit file (its actual intended
context). The directive's own symbol-name argument is never fully
consumed while parsing it, which desyncs everything parsed afterward, so
the resulting error surfaces somewhere else in the file rather than
pointing at the `@donotprefix` line itself. Its sibling directive,
`@donotprefixunit` (which takes no argument), is unaffected there, so the
bug is specific to this argument-taking form.
:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
the symbol-name argument is now fully consumed in both places it's read,
and `@donotprefix <symbolName>` compiles correctly, both as a top-level
`.ras` directive and inside a `.tru` unit file.
