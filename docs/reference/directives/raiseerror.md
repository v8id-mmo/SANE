# `@raiseerror`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Immediately aborts compilation with a custom error message, exactly like
[`@error`](error.md). Typically paired with `@ifdef`/`@ifndef` as a
compile-time assertion, so a missing required setting fails fast with a
clear message instead of letting compilation continue and fail
confusingly somewhere else.

## Syntax

    @raiseerror "<message>"

## Parameters

- `<message>`: the text shown as the fatal error. Compilation stops right
  there; nothing after it is processed.

## Example

```pascal
program RaiseErrorDemo;

@ifdef require_target_c64u
@raiseerror "This example requires @define require_target_c64u to be set."
@endif

begin
	loop();
end.
```

This example compiles cleanly as shipped, since `require_target_c64u` is
never `@define`d, so the guarded `@raiseerror` is skipped. Removing the
`@ifdef`/`@endif` guard (or adding a matching `@define` above it) makes
the `@raiseerror` line actually fire, aborting compilation with the given
message.

[:material-download: Download this example](../../assets/examples/raiseerror.ras){ .md-button download }
