# Compatibility tags

Every reference page in this site (keywords, builtins, operators, types)
carries exactly one badge right under its title, answering a single
question: **does SANE's compiler currently produce different behavior for
this than vanilla TRSE does?**

There are exactly three possible tags:

## `TRSE`

Inherited from vanilla TRSE, and SANE's compiler currently produces the
**same behavior** for it, even if that behavior has a known bug. This is
the default, and covers the large majority of pages.

A known, documented bug does **not** by itself change this tag. Writing
down "we know about this limitation" is not the same as actually fixing
the compiler. If a page has a `TRSE` badge and a **Known limitations**
section, that means: this is exactly how classic TRSE behaves too, warts
and all, and SANE hasn't changed it (yet).

## `TRSE (modified in SANE)`

Inherited from vanilla TRSE, but SANE's compiler has **actually been
changed** so it behaves differently now, typically because a known bug
was really fixed in code, not just documented.

## `SANE`

Doesn't exist in vanilla TRSE at all: a keyword, builtin, operator, or
type that's entirely new to this fork.

---

## How the tag is decided

Every tag is decided by comparing SANE's actual compiler behavior against
an unmodified `leuat/TRSE` checkout. In order:

1. Does this exist in vanilla TRSE at all? If no, it's `SANE`, done.
2. If yes, does SANE's actual codegen for it currently differ from the
   original's? If no, it's `TRSE`. If yes, it's `TRSE (modified in SANE)`.

---

## Known-limitation status: `Fixed in SANE`

The three tags above are a single badge for an entire page. A page can
still have several independent "Known limitations" bullets underneath
it, some still open in both compilers and some since fixed in only one
of them. A second, separate marker handles that finer-grained case:

**`Fixed in SANE`** tags one specific bullet inside a page's Known
Limitations section: this exact limitation used to be true for both
vanilla TRSE and SANE, and SANE's compiler has since been changed to no
longer have it. A bullet with no such marker means the limitation is
still true today, in both compilers.

**Known limitation bullets are never deleted once a bug is fixed, only
tagged.** The bullet is what tells a vanilla TRSE user that the bug
exists at all; TRSE gets none of SANE's fixes, so removing the bullet
the moment SANE fixes it would erase the only record a TRSE reader would
ever see. The original bug description stays in full (what vanilla TRSE
actually does), with the `Fixed in SANE` marker and a short note on what
SANE does differently appended to it.

This marker is independent of the page-level badge above it: a page can
carry `TRSE (modified in SANE)` because of one fixed bullet, while other
bullets on the same page remain untagged (still open in both compilers).

## Worked example: `sine[]`

`sine[]` exists in both vanilla TRSE and SANE. For a while, a known
limitation (the builtin auto-init mechanism only scanned the current
file's own text, so a `sine[]` usage that only appeared inside a `@use`d
unit file was silently missed) was present in **both**, unchanged, and
the page carried a plain `TRSE` badge.

SANE's scan has since been extended to also cover `@use`d unit files, so
the page's badge is now `TRSE (modified in SANE)`. The known-limitation
bullet describing the original bug is still there, unchanged in its
description of vanilla TRSE's behavior, just with a `Fixed in SANE`
marker and a closing note on what SANE's scan does differently now,
rather than being deleted.
