# `private`

:material-tag: [**TRSE**](../../tags.md): same behavior as vanilla TRSE.

Reserved as part of a `class`/`record` member-visibility system (paired
with `public`), in the usual Pascal/object-oriented sense of marking a
field or method as internal to the type. Not currently usable; see Known
limitations.

## Syntax

    <ClassName> = class
      private
        <fields>
      public
        <fields/methods>
    end;

## Known limitations

**Using `private` (or its counterpart `public`) as a class/record
visibility section is a hard compile error, not a silently-ignored
no-op.** Neither keyword is actually read anywhere while parsing a
`class`/`record` body; writing one produces an immediate, generic parse
error at that line, rather than being accepted and having no effect. In
practice, every field and method in a TRSE/SANE `class` or `record` is
effectively public: there is currently no way to mark a member private.

No working example exists to show here; a broken example would be worse
than none, so none is included on this page.

This isn't planned to change: adding real visibility (parsing the
keywords, threading a visibility flag through the symbol table, and
enforcing it against external access) is real feature work, not a narrow
fix, with no existing user demand driving it.
