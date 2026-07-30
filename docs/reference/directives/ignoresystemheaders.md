# `@ignoresystemheaders`

:material-tag: [**TRSE (modified in SANE)**](../../tags.md): vanilla
TRSE silently accepts this directive despite it having no effect; SANE
raises a clear compile error instead.

A build-time directive intended to suppress automatically-included
system/platform header content from the compiled output.

## Syntax

    @ignoresystemheaders

Takes no arguments.

**No example is shown on this page.** This directive always fails to
compile on SANE (see Known limitations below), so a working example
can't be given; a broken example is worse than none.

## Known limitations

**Currently has no effect in vanilla TRSE.** The directive compiles
cleanly (it also prints a stray debug line to the console, harmless but
a little unexpected), but nothing else in the compiler ever checks the
flag it sets, on the C64 target or otherwise. Using it doesn't change the
compiled output in any observable way.

:material-check-decagram: **[Fixed in SANE](../../tags.md#known-limitation-status-fixed-in-sane)**:
since the directive can never have any effect on this fork's C64-only
target, using it now stops compilation with a clear error instead of
silently doing nothing.
