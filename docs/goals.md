# Project Goals

SANE started from a simple frustration: TRSE is a genuinely good Pascal compiler for 8-bit systems, but using it meant working inside its own bundled IDE, dealing with quirks that had been sitting unfixed for a long time, and reaching for community forum threads whenever the official documentation didn't cover something (which was often). Just as much of it came from the sheer amount of trial and error it took to even figure out how something was actually supposed to behave: more hours than I'd like to admit went into debugging code that looked completely correct, rewriting the same line five different ways, staring at generated assembly, assuming the bug had to be in my own program, because why would it be the compiler. The [`sine[]`](reference/builtins/initsinetable.md) auto-init gap is a good concrete example of exactly that pattern: the actual fix, once found, was tiny, but getting there took far longer than it should have, precisely because the compiler wasn't even on the list of suspects until every other explanation had already been ruled out.

That specific bug is actually where the rest of this followed from. It occurred to me, once I'd found it, that I could just fix it directly in TRSE and move on. But something only really counts as fixed once it's actually been tested, and TRSE supports dozens of systems I have no way of testing myself. A fix I could only verify against the one platform I actually use could easily leave the same class of bug, or a new one, sitting untouched on every other target.
On top of that, I hadn't touched TRSE's own bundled IDE in a long time by that point either: I'd already moved to my own VS Code setup, built around TRSE's CLI compile mode. Staring at a compiler I only ever built and tested against one system, through one workflow, the next question answered itself: if none of that other code was ever exercised, and none of it was ever going to ship to anyone but me, there was no real reason to keep carrying it. Smaller, C64-only code is also easier to read and debug than the same logic spread across a dozen systems, and since this was never meant to be a general-purpose tool to begin with, cutting the rest away was the obvious move. That's the actual origin of SANE's scope, not a plan decided on up front: one target (C64), one workflow (the command line), and a small, concrete list of things to actually get right, arrived at by following one bug all the way through.

Signed arithmetic gets called out as its own priority for a similarly concrete reason: I have a future project in mind that genuinely depends on it working correctly, not the partially-working state it's in today. That's not something I can defer as a nice-to-have, it's something that has to be sorted out before that project can even get off the ground. It's also the real difference between this and everything else on the Known Bugs page: all of it is worth fixing, but signed arithmetic is the one piece actually blocking something I already intend to build.

Once it was in reasonable shape, it seemed like it could plausibly help at least a handful of other people hitting the same walls, so making it public was an easy call from there, and going public meant it needed an actual name. It's hard to miss, in hindsight, that the whole thing started with `sine[]` and ended up called SANE, but the name stuck for more than just the coincidence: between **signed arithmetic** specifically working the way it's supposed to, and wanting a compiler that behaves correctly instead of quietly doing the wrong thing (**no errors**), "SANE" fit what the project had actually become, the deliberate opposite of TRSE's own "Syntax Error" 😉.

The thing I'd been missing the whole time was the documentation.Precise and detailed enough to actually trust, so that became the third piece I set out to build myself. That documentation site started out as notes for myself, and turned out broad and accurate enough to be useful to anyone working with TRSE or SANE, not just to me.

## What SANE is trying to do

- **Be a CLI tool, not an IDE.** No bundled editor, no bundled image/
  sprite/level editor, no bundled emulator, no GUI framework overhead in
  the build at all. Just a compiler you invoke from a terminal (or from a
  script, or from another editor's build task), that takes source files
  in and produces a prg/d64/etc out.
- **Have a real VS Code integration.** Syntax highlighting, a build task
  that jumps straight to the offending line on a compile error, and
  eventually proper project/settings configuration from inside the
  editor, so VS Code becomes a first-class way to work with the language,
  not just a text box in front of a separate compiler.
- **Have documentation that's actually complete and actually correct.**
  This site is that goal, in progress: every keyword, builtin, operator,
  type, and constant, written from and cross-checked against the real
  compiler source rather than copied from memory or from TRSE's own
  incomplete docs.
- **Fix every known compiler bug**, instead of quietly working around
  them project after project. See the [Known Bugs](known-bugs.md) page
  for the current list; each one gets fixed in the open, with the fix
  recorded in the [changelog](changelog.md).
- **Get signed arithmetic actually right.** This deserves calling out on
  its own: right now, signed comparisons, signed multiplication, and
  signed division are all incomplete or outright wrong in specific cases. Fixing all of it properly, not just the common cases, is one of the highest-priority goals here.
- **Grow the language when there's a real reason to**, not for its own
  sake. New builtins or keywords get added when they solve an actual
  problem that came up, not speculatively.

## Ideas being considered for later

These aren't scheduled, and some may never happen; most of them are
nice-to-haves rather than firm commitments, but they're worth writing
down so they don't get lost:

- **Better compiler diagnostics.** Clearer error messages and accurate
  line numbers; right now some errors point at the wrong line entirely
  (usually because a parser desync earlier in the file shifts where the
  error actually surfaces, see the parser-related entries on the
  [Known Bugs](known-bugs.md) page for concrete examples of this).
- **A wider type system.** Once the signed-arithmetic bugs are actually
  fixed, extending the type system further (proper fixed-point or
  floating-point support) becomes worth doing without inheriting the same
  class of bugs into a brand-new type.
- **Commodore 64 Ultimate (C64U) support.** The C64U/Ultimate-II+
  hardware exposes real, documented features over a command interface:
  file and directory access, network/TCP access from a running program,
  a real-time clock, extra SID chips, and an audio sampler. Exposing
  these for anyone targeting that hardware would be a genuinely new
  capability, not something vanilla TRSE has. Given how much staying
  TRSE-compatible actually matters here, the more likely shape for this
  is a separate, external unit that talks to that hardware using the
  language as it already exists, rather than adding new builtins to the
  compiler itself; that way the compiler stays exactly as compatible
  with TRSE as it is today, and the Ultimate-specific pieces stay purely
  opt-in on top of it. A smaller, faster win in the same space: a simple
  deploy helper that uploads and runs a compiled program on real
  Ultimate hardware over the network, as a complement to testing in an
  emulator. This is additive to plain C64 support, not a replacement for
  it; a project not targeting Ultimate hardware would never notice it's
  there.

## What SANE deliberately isn't trying to be

- **Not trying to compete with TRSE**, even though a fork with its own
  name, its own bug list, and its own documentation site can look
  exactly like that from a distance. SANE only exists because TRSE
  does. Everything here started life as a real TRSE bug/feature, and, as the
  next section spells out, most of what gets fixed or documented
  benefits TRSE users directly, not just SANE's own narrower slice of
  it. Something that depends entirely on the original for its own
  reason to exist, and hands most of its output straight back to that
  original's users, isn't positioned against it: it's a smaller branch growing out of the same tree, not a rival to it.
- **Not aiming to merge back into original TRSE**, or to track it
  release-for-release. SANE is a fork with its own direction; the
  [Compatibility Tags](tags.md) system exists specifically so it stays
  clear, page by page, where SANE has actually diverged. The
  [Known Bugs](known-bugs.md) page being fully public plays into this
  too: it's not written for SANE's own benefit alone, it's there so
  that someone more capable than me, or who simply runs into the same
  odd behavior themselves, has an actual, correct root-cause writeup to
  work from if they ever want to fix the same thing in original TRSE,
  whether or not SANE itself ever merges back.
- **Not a multi-platform retro compiler.** Classic TRSE supports dozens
  of 8/16-bit systems. SANE dropped all of them on purpose to put full
  attention on getting one platform right, rather than spreading fixes
  thin across many.
- **Not trying to add any built-in GUI/IDE in any form.** That
  removal was deliberate, not a temporary state waiting to be reversed.

## Where this leaves TRSE users

Everything above is written from SANE's own point of view, but it's worth
repeating what the front page already says: since SANE is still deeply
TRSE-compatible, most of what's built here (documentation, bug fixes)
directly **benefits anyone using plain classic TRSE too**, not just SANE
users. See the [homepage](index.md) for what that means in practice.
