# `@setvalue`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Sets a raw project/settings configuration key directly from source code,
by its exact internal name. This is the low-level counterpart to
[`@projectsettings`](projectsettings.md): `@projectsettings` only exposes
a small, curated set of friendly setting names (`startaddress`,
`exomize`, and similar), while `@setvalue` can set any configuration key
the compiler reads, as long as you know its exact internal name. There's
no validation of the key name: an unrecognized key is silently accepted
and simply has no effect, since nothing in the compiler ever reads it
back.

## Syntax

    @setvalue "<key>" <value>

## Parameters

- `<key>`: a quoted string naming the configuration key to set, exactly
  as the compiler's internal settings file would spell it (e.g.
  `"exomizer_toggle"`, `"output_type"`, `"remove_unused_symbols"`).
- `<value>`: the new value, a quoted string or a bare number.

## Example

```pascal
program SetValueDemo;

@setvalue "exomizer_toggle" 0

begin
	loop();
end.
```

This disables Exomizer compression for the build, the same effect
`@projectsettings "exomize" "0"` has, but by setting the underlying
configuration key directly.

[:material-download: Download this example](../../assets/examples/setvalue.ras){ .md-button download }
