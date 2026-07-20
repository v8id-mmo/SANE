# `@error`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Immediately aborts compilation with a custom error message. Typically
paired with `@ifdef`/`@ifndef` as a compile-time assertion, to fail fast
with a clear message when a required `@define` hasn't been set, instead of
letting compilation continue and fail confusingly somewhere else.

## Syntax

    @error "<message>"

## Parameters

- `<message>`: the text shown as the fatal error. Compilation stops right
  there; nothing after it is processed.

## Example

```pascal
program ErrorDemo;

@ifdef require_target_c64u
@error "This example requires @define require_target_c64u to be set."
@endif

begin
	loop();
end.
```

This example compiles cleanly as shipped, since `require_target_c64u` is
never `@define`d, so the guarded `@error` is skipped. Removing the
`@ifdef`/`@endif` guard (or adding a matching `@define` above it) makes the
`@error` line actually fire, aborting compilation with the given message.

[:material-download: Download this example](../../assets/examples/error.ras){ .md-button download }
