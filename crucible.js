#!/usr/bin/env crucible
//
// Entry point. Lives in ~/src/github.com/bkegley/dotfiles once reviewed.
// Replaces symlink.sh and the empty scripts/{brew,setup}.sh stubs.
//
// Run from the dotfiles directory:
//   ./crucible.js --dry-run
//   ./crucible.js
//
// NOTE ON ORDERING: crucible does NOT apply declarations in script order.
// Non-batched types plan in sequence; batched types (brew, mise, defaults, ...)
// are planned afterward in Go-map order, then actions run concurrently.
// Homebrew serializes via SerialGroup, but there is no cross-type dependency
// ordering. A truly fresh machine will need TWO passes:
//   pass 1 — installs brew/mise, clones ~/.oh-my-zsh
//   pass 2 — mise tools resolve, shell config works
// This is expected, not a bug. See TODO.md.

const c = require("crucible");

// ---------------------------------------------------------------------------
// Profile selection — marker file (decision B)
// ---------------------------------------------------------------------------
// There is no process.env and no CLI arg passthrough in the crucible runtime,
// and c.facts.file() exposes only exists/hash/mode (no content). So the machine
// identity comes from the presence of a marker file.
//
// On a work machine, once:   touch ~/.crucible-work
//
// Adding a third profile means adding another marker — there is no way to read
// a profile *name* out of a file.
//
// ⚠️ c.facts.file() does NOT expand "~". Unlike the declaration functions
// (c.file/c.symlink/c.dir), which run paths through expandPath(), the facts
// module hands the string straight to os.Lstat(). A "~/..." path is treated
// literally and is ALWAYS false — which would silently pin every machine to the
// personal profile. Verified against internal/fact/file.go and confirmed with a
// real os.Lstat("~/.zshrc") → false.
//
// There is also no way to derive $HOME from facts: c.facts.os exposes only
// name / arch / hostname (no user, no home). So the marker path is a literal
// absolute path. Alternatively, a RELATIVE marker inside the dotfiles repo
// works without hardcoding a username, since facts.file() resolves relative
// paths against cwd (= the source dir) — but a repo-local marker would be
// tracked by git, defeating the purpose. Hence the absolute path.
const MARKER = "/Users/bkegley/.crucible-work";
const isWork = c.facts.file(MARKER).exists;
const profile = isWork ? "work" : "personal";

c.log(`crucible profile: ${profile} (host ${c.facts.os.hostname})`);

if (!c.facts.homebrew.available) {
    c.log("WARNING: Homebrew not available — package declarations will fail.");
    c.log("Install it first: https://brew.sh");
}

// ---------------------------------------------------------------------------
// Shared, then exactly one profile
// ---------------------------------------------------------------------------
// Profiles CANNOT subtract. Declarations accumulate and there is no "unset",
// so shared.js holds only the true intersection. Anything conditional lives in
// exactly one profile — never declare in shared and try to remove it later.
require("./profiles/shared")(c);
require("./profiles/scripts")(c);
require(`./profiles/${profile}`)(c);

// ---------------------------------------------------------------------------
// Optional machine-local overrides (gitignored)
// ---------------------------------------------------------------------------
// The guard is REQUIRED. A missing require() throws and aborts the entire plan,
// so an unguarded require of an optional file breaks every machine that lacks
// it. c.facts.file() resolves relative to the source dir (cwd), so the bare
// relative path is correct here.
//
// Add to .gitignore:  crucible.local.js
//
// Unlike the marker above, a bare relative path is CORRECT here: facts.file()
// hands it to os.Lstat() unchanged, and crucible runs with cwd = the source dir,
// so "crucible.local.js" resolves next to this script. No "~" involved.
if (c.facts.file("crucible.local.js").exists) {
    c.log("applying crucible.local.js");
    require("./crucible.local")(c);
}
