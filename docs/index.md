# SANE / TRSE Documentation

**SANE** is a Commodore 64-only, CLI-only fork of
[TRSE (Turbo Rascal Syntax Error)](https://github.com/leuat/TRSE), a
Pascal-like compiler for 8-bit systems. The language itself is
99.99% TRSE-compatible, since this site documents the language and
standard library as SANE's compiler actually implements them today,
cross-checked directly against the compiler source rather than copied
from memory or from TRSE's own (incomplete) docs.

If you already know TRSE: almost everything here works exactly as it does
upstream. Every page is tagged so you can tell at a glance whether it's
unchanged from TRSE, changed in SANE, or new to SANE. See
[Compatibility Tags](tags.md) for details.

## Where to start

- New to the language? Start with [Getting Started](getting-started.md).
- Looking for a specific keyword, builtin, operator, or type? Use the
  search box, or browse the Reference section.
- Looking for a known bug or limitation before you burn an hour on it?
  Every affected page has a **Known limitations** section. Search for
  "Known limitation" or check the relevant Reference page directly.

## What this covers

- Every language keyword
- Every builtin function/array (`sine[`, `rand(`, `sqrt(`, `atan2(`, etc.)
- Every operator, including where signed-arithmetic behavior has known gaps
- Every type
- Predefined constants (colors, keyboard codes, SID/sprite/VIC registers)
- Runnable, CLI-compiled example programs
- C64/6502-specific platform notes

This is scoped to the Commodore 64 target only. SANE has dropped every
other system TRSE supports (VIC20, PET, C128, NES, Apple II, Atari, Amiga,
Z80/MSX/Spectrum, x86, and others).
