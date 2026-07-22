# SANE / TRSE Documentation

**SANE** - **S**igned **A**rithmetic, **N**o **E**rrors

SANE is a **Commodore 64-only**, **CLI-only** fork of
[TRSE (Turbo Rascal Syntax Error)](https://github.com/leuat/TRSE), a
Pascal compiler for 8-bit systems. The language itself is 99.99%
TRSE-compatible. This site documents the SANE/TRSE language and standard
library as the compiler actually implements them, cross-checked directly
against the compiler source rather than copied from TRSE's own limited
and incomplete docs.

!!! tip "Using vanilla TRSE?"
    This site works for you too, not just SANE users. The official TRSE
    documentation is incomplete and out of date in places; this site was
    written from scratch against the actual compiler source specifically
    to fix that. Outside of pages tagged **SANE** or
    **TRSE (modified in SANE)** (see [Compatibility Tags](tags.md)),
    everything here applies equally to vanilla TRSE. The one thing to
    keep in mind: this site only covers the Commodore 64 target, so parts
    of it won't apply if you're targeting a different system.

If you already know **TRSE**: almost everything here works exactly as it
does in the original. Every page carries a small badge so you can tell at
a glance whether it's unchanged from TRSE, changed in SANE, or new to
SANE. See [Compatibility Tags](tags.md) for details.

## Where to start

- :material-flag-checkered: New to the language? Start with
  [Getting Started](getting-started.md).
- :material-magnify: Looking for a specific keyword, builtin, operator,
  or type? Use the search box, or browse the Reference section.
- :material-bug-outline: Looking for a known bug or limitation before you
  burn an hour on it? Check the [Known Bugs](known-bugs.md) page, or the
  **Known limitations** section on the relevant Reference page directly.
- :material-target: Curious what this project is actually trying to
  achieve? See [Project Goals](goals.md).

## What this site covers

- Every language keyword
- Every builtin function/array (`sine[`, `rand(`, `sqrt(`, `atan2(`, etc.)
- Every operator, including where signed-arithmetic behavior has known gaps
- Every type
- Predefined constants (colors, keyboard codes, SID/sprite/VIC registers)
- Runnable, CLI-compiled example programs
- C64/6502-specific platform notes

This is scoped to the Commodore 64 target only. SANE has dropped every
other system TRSE supports (VIC-20, PET, C128, NES, Apple II, Atari,
Amiga, Z80/MSX/Spectrum, x86, and others), to put full attention on
getting one platform right. See [Project Goals](goals.md) for the
reasoning behind that, and everything else this fork is working toward.

---

<div class="grid cards" markdown>

-   :material-bug-outline:{ .lg .middle } **[Known Bugs](known-bugs.md)**

    ---

    Every confirmed compiler defect, tracked in one place until it's
    fixed.

-   :material-target:{ .lg .middle } **[Project Goals](goals.md)**

    ---

    What SANE is actually trying to accomplish, and what it isn't.

-   :material-history:{ .lg .middle } **[Changelog](changelog.md)**

    ---

    What's actually changed, and when.

</div>

---

## Thanks

None of this would exist without [leuat](https://github.com/leuat)'s
original TRSE and the community that's grown up around it: a genuinely
capable, freely available 8-bit Pascal compiler, plus years of forum
threads and tutorials written by other TRSE users that this project
leaned on constantly along the way. SANE only exists because that work
was already there to fork, narrow down, and build on top of.

---

*This documentation site was generated with the assistance of Claude Code,
under human review and direction rather than as a fully automated
process. Every keyword, builtin, operator, and type page is cross-checked
against the compiler source, and every example is compiled with the real
CLI tool before publishing, per the accuracy rules this project holds
itself to. If you spot an error, please open an issue.*
