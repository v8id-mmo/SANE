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

**This directive does not currently compile, in any configuration.**
Confirmed by testing: it fails both as a plain top-level directive in a
`.ras` main program, and inside a `.tru` unit file (its actual intended
context). The root cause is confirmed in the source: `Parser::
PreprocessSingle`'s handler for `donotprefix` reads the symbol name
argument but never consumes (`Eat()`s) that token, desyncing everything
parsed afterward. Its sibling directive, `@donotprefixunit` (which takes
no argument), was tested side by side and works fine, confirming the bug
is specific to this argument-taking form. No working example exists to
show here; a broken example would be worse than none, so none is
included on this page.
