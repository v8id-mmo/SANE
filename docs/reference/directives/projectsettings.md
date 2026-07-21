# `@projectsettings`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Overrides a project setting directly from source code, the same settings
that would otherwise come from the project's own configuration file. Lets
a single `.ras` file carry a setting override with it, rather than
requiring every project that uses it to remember to set it up separately.
Only a small, curated set of friendly setting names is recognized here;
see [`@setvalue`](setvalue.md) for setting an arbitrary raw configuration
key by its exact internal name instead.

## Syntax

    @projectsettings "<key>" <value>

No parentheses and no comma between the key and the value; just the
directive followed by a quoted key name and the value.

## Parameters

- `<key>`: a quoted string naming which setting to override, e.g.
  `"startaddress"`, `"exomize"`.
- `<value>`: the new value. A quoted string or a bare number/address
  (e.g. `$0900`), depending on what the key expects.

## Example

```pascal
program ProjectSettingsDemo;

@projectsettings "startaddress" $0900

begin
	screen_bg_col := black;
	loop();
end.
```

This moves the program's start address from the project's usual default
to `$0900`.

[:material-download: Download this example](../../assets/examples/projectsettings.ras){ .md-button download }
