# Compatibility tags

Every reference page in this site (keywords, builtins, operators, types)
carries exactly one badge right under its title, answering a single
question: **does SANE's compiler currently produce different behavior for
this than vanilla upstream TRSE does?**

There are exactly three possible tags:

## `TRSE`

Inherited from upstream TRSE, and SANE's compiler currently produces the
**same behavior** for it, even if that behavior has a known bug. This is
the default, and covers the large majority of pages.

A known, documented bug does **not** by itself change this tag. Writing
down "we know about this limitation" is not the same as actually fixing
the compiler. If a page has a `TRSE` badge and a **Known limitations**
section, that means: this is exactly how upstream TRSE behaves too, warts
and all, and SANE hasn't changed it (yet).

## `TRSE (modified in SANE)`

Inherited from upstream TRSE, but SANE's compiler has **actually been
changed** so it behaves differently now, typically because a known bug
was really fixed in code, not just documented. This is named as a variant
of `TRSE` (not `SANE (fixed)`) on purpose: it's about *origin* first
(this feature comes from TRSE) and *behavior difference* second.

## `SANE`

Doesn't exist in vanilla TRSE at all: a keyword, builtin, operator, or
type that's entirely new to this fork.

---

## Worked example: `sine[]`

`sine[]` exists in both vanilla TRSE and SANE. Today, a known limitation
(the builtin auto-init mechanism only scans the current file's own text,
so a `sine[]` usage that only appears inside a `@use`d unit file is
silently missed) is present in **both**, unchanged. SANE hasn't touched
that part of the compiler yet, only documented the bug and a workaround.
So right now `sine[]` carries the **`TRSE`** tag, plus a separate "Known
limitation" callout further down its page describing the bug and the
workaround; the callout is independent of the tag.

If the compiler's scan is later actually extended to cover `@use`d unit
files, the tag changes to **`TRSE (modified in SANE)`**, and the
known-limitation callout gets updated to describe what changed (or
removed if it's no longer relevant).

## How the tag is decided

Every tag is decided by comparing SANE's actual compiler behavior against
an unmodified upstream `leuat/TRSE` checkout, never from memory or
assumption. In order:

1. Does this exist in upstream TRSE at all? If no, it's `SANE`, done.
2. If yes, does SANE's actual codegen for it currently differ from
   upstream's? If no, it's `TRSE`. If yes, it's `TRSE (modified in SANE)`.
