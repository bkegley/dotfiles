// Tools installed by their own installers rather than a package manager.
//
// c.script() is crucible's ONLY arbitrary-command door. Semantics, verified in
// internal/fact/script.go and internal/action/script.go:
//
//   check   — run via `sh -c`. Exit 0 => already installed, DO NOTHING.
//             Any non-zero exit => run install. Both options are MANDATORY.
//   install — run via `sh -c` only when check fails.
//
// So idempotency is entirely on you: the check must be cheap, offline, and must
// not lie. A check that always fails reinstalls on every apply; a check that
// always passes means the tool never installs.
//
// ⚠️ There is NO uninstall and NO upgrade. c.script() has no state:"absent" and
// no notion of a version. It is install-once-if-missing. Anything needing
// version management belongs in mise instead.
//
// ⚠️ These commands pipe the network into a shell. Crucible cannot verify them,
// and `crucible apply --dry-run` shows only the command string, never what the
// remote script would do. Everything here is a first-party vendor URL over
// HTTPS; treat adding a new one as the security decision it is.
//
// ⚠️ CHECKS USE ABSOLUTE PATHS ON PURPOSE. A bare `claude --version` depends on
// the PATH crucible inherited. Verified: under a minimal PATH
// (/usr/bin:/bin) every bare check FAILS, so crucible would re-run all four
// installers on every single apply. `test -x "$HOME/..."` is exact, spawns no
// process, and cannot be fooled by a broken binary that still prints a version.
//
// The tradeoff: these checks assert a specific install LOCATION, so if a vendor
// changes its default install dir the check silently fails and the installer
// re-runs. That is the safer failure direction (reinstall, not skip-forever),
// and the installers here are all idempotent.

module.exports = (c) => {
    // -----------------------------------------------------------------------
    // Claude Code — native installer (explicitly NOT the Homebrew cask)
    // -----------------------------------------------------------------------
    // Official command, confirmed against code.claude.com/docs/en/setup:
    //   curl -fsSL https://claude.ai/install.sh | bash
    //
    // Why native over `brew install --cask claude-code`:
    //   - Native installs AUTO-UPDATE in the background. Homebrew casks do not
    //     and need `brew upgrade claude-code`.
    //   - The installer manages ~/.local/bin/claude as a symlink into
    //     ~/.local/share/claude/versions/<version>, which is exactly the layout
    //     already on this machine (currently 2.1.220).
    //
    // Because it self-updates, this declaration should be understood as
    // "ensure claude exists", NOT "manage claude's version". Crucible will
    // never upgrade it and never needs to.
    //
    // The installer also accepts a channel or pinned version if ever wanted:
    //   ... | bash -s stable
    //   ... | bash -s 2.1.89
    c.script("claude-code", {
        install: "curl -fsSL https://claude.ai/install.sh | bash",
        check: 'test -x "$HOME/.local/bin/claude"',
    });

    // -----------------------------------------------------------------------
    // uv / uvx — Astral's Python package manager
    // -----------------------------------------------------------------------
    // Installs to ~/.local/bin.
    c.script("uv", {
        install: "curl -fsSL https://astral.sh/uv/install.sh | sh",
        check: 'test -x "$HOME/.local/bin/uv"',
    });

    // -----------------------------------------------------------------------
    // rustup — Rust toolchain
    // -----------------------------------------------------------------------
    // -y accepts defaults so the installer never blocks on a prompt. Crucible
    // runs install commands non-interactively; an installer that waits for
    // stdin would hang the apply.
    //
    // Installs to ~/.cargo/bin, which shell/init.sh already sources via
    // ~/.cargo/env. Note mise's cargo: backend (lumen, mdcat) needs this
    // toolchain present to build from source.
    c.script("rustup", {
        install: "curl -fsSL https://sh.rustup.rs | sh -s -- -y",
        check: 'test -x "$HOME/.cargo/bin/rustup"',
    });

    // -----------------------------------------------------------------------
    // NOT WANTED — aider
    // -----------------------------------------------------------------------
    // Deliberately not declared, so a new machine never installs it.
    //
    // ⚠️ This does NOT remove the existing one. c.script() has no
    // state:"absent", so the copy already at ~/.local/bin/aider stays until you
    // remove it by hand:
    //     uv tool uninstall aider-chat

    // -----------------------------------------------------------------------
    // Punted — see TODO.md. Provenance unconfirmed, so no declaration yet.
    // -----------------------------------------------------------------------
    // bunyan, herdr, cass, tunl, plannotator, container-use/cu,
    // temporal/temporal-service, goose, and the bun-global pa/qmd/sc.
    //
    // Several are almost certainly your own repos, which want
    // c.git() + a build step rather than c.script() against a URL. Writing a
    // wrong installer here is worse than writing none, since a bad `check`
    // silently reruns `install` on every single apply.
};
