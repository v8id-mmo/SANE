# `public`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reserved as part of a `class`/`record` member-visibility system (paired
with `private`), meant to mark a field or method as externally accessible
in the usual Pascal/object-oriented sense. Not currently usable; see Known
limitations.

## Syntax

    <ClassName> = class
      private
        <fields>
      public
        <fields/methods>
    end;

## Known limitations

**Using `public` (or its counterpart `private`) as a class/record
visibility section is a hard compile error, not a silently-ignored
no-op.** Neither keyword is actually read anywhere while parsing a
`class`/`record` body; writing one produces an immediate, generic parse
error at that line, rather than being accepted and having no effect. In
practice, every field and method in a TRSE/SANE `class` or `record` is
effectively public already: there is currently no way to write a
`private` section for `public` to meaningfully contrast with.

No working example exists to show here; a broken example would be worse
than none, so none is included on this page.
