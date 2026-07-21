# `@donotprefix`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Intended to disable automatic unit-name prefixing for a single named
symbol (a more targeted version of [`@donotprefixunit`](donotprefixunit.md),
which disables it for the whole unit).

## Syntax

    @donotprefix <symbolName>;

## Parameters

- `<symbolName>`: the identifier to exempt from prefixing.

## Known limitations

**This directive does not currently compile, in any configuration.** It
fails both as a plain top-level directive in a `.ras` main program, and
inside a `.tru` unit file (its actual intended context). The directive's
own symbol-name argument is never fully consumed while parsing it, which
desyncs everything parsed afterward, so the resulting error surfaces
somewhere else in the file rather than pointing at the `@donotprefix`
line itself. Its sibling directive, `@donotprefixunit` (which takes no
argument), is unaffected, so the bug is specific to this argument-taking
form. No working example exists to show here; a broken example would be
worse than none, so none is included on this page.
