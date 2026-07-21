# Project Goals

SANE started from a simple frustration: TRSE is a genuinely good Pascal
compiler for 8-bit systems, but using it meant working inside its own
bundled IDE, dealing with quirks in signed-number handling that had been
sitting unfixed for a long time, and reaching for community forum threads
whenever the official documentation didn't cover something (which was
often). Rather than trying to fix all of that inside the full,
every-platform version of TRSE, SANE narrows the scope on purpose: one
target (the Commodore 64), one workflow (the command line, driven from
whatever editor you already use), and a small, concrete list of things to
actually get right.

To be specific about where this actually came from: I needed a compiler I
could rely on for my own C64 projects, not a general-purpose tool for a
wide audience. The bugs, the IDE-only workflow, and the gaps in the
official documentation kept getting in my way often enough that fixing
them for myself was worth the effort on its own. Once it was in reasonable
shape, it seemed like it could plausibly help at least a handful of other
people hitting the same walls, so making it public was an easy call from
there. The documentation site in particular started out as notes for
myself, and turned out broad and accurate enough to be useful to anyone
working with TRSE or SANE, not just to me.

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
  signed division are all incomplete or outright wrong in specific cases
  (see the arithmetic entries on the [Known Bugs](known-bugs.md) page).
  Fixing all of it properly, not just the common cases, is one of the
  highest-priority goals here.
- **Grow the language when there's a real reason to**, not for its own
  sake. New builtins or keywords get added when they solve an actual
  problem that came up, not speculatively. If you have an idea for
  something genuinely missing, that's exactly the kind of thing this
  point is for.

## Ideas being considered for later

These aren't scheduled, and some may never happen, but they're worth
writing down so they don't get lost:

- **Better compiler diagnostics.** Clearer error messages and accurate
  line numbers; right now some errors point at the wrong line entirely
  (usually because a parser desync earlier in the file shifts where the
  error actually surfaces, see the parser-related entries on the
  [Known Bugs](known-bugs.md) page for concrete examples of this).
- **A wider type system.** Once the signed-arithmetic bugs are actually
  fixed, extending the type system further (proper fixed-point or
  floating-point support) becomes worth doing without inheriting the same
  class of bugs into a brand-new type.
- **Commodore 64 Ultimate (C64U) support.** The Ultimate-64/Ultimate-II+
  hardware exposes real, documented features over a command interface:
  file and directory access, network/TCP access from a running program,
  a real-time clock, extra SID chips, and an audio sampler. Exposing
  these as language-level builtins for anyone targeting that hardware is
  a genuinely new capability, not something vanilla TRSE has. A smaller,
  faster win in the same space: a simple deploy helper that uploads and
  runs a compiled program on real Ultimate hardware over the network,
  as a complement to testing in an emulator. This is additive to plain
  C64 support, not a replacement for it; a project not targeting Ultimate
  hardware would never notice it's there.

## What SANE deliberately isn't trying to be

- **Not a multi-platform retro compiler.** Classic TRSE supports dozens
  of 8/16-bit systems. SANE dropped all of them on purpose to put full
  attention on getting one platform right, rather than spreading fixes
  thin across many.
- **Not aiming to merge back into original TRSE**, or to track it
  release-for-release. SANE is a fork with its own direction; the
  [Compatibility Tags](tags.md) system exists specifically so it stays
  clear, page by page, where SANE has actually diverged.
- **Not trying to keep the built-in GUI/IDE around in any form.** That
  removal was deliberate, not a temporary state waiting to be reversed.

## Where this leaves TRSE users

Everything above is written from SANE's own point of view, but it's worth
repeating what the front page already says: since SANE is still deeply
TRSE-compatible, most of what's built here (documentation, bug fixes)
directly **benefits anyone using plain classic TRSE too**, not just SANE
users. See the [homepage](index.md) for what that means in practice.
