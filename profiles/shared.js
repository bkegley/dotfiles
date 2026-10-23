// Shared configuration — the TRUE INTERSECTION of every machine.
//
// Profiles cannot subtract. If something belongs on only one machine, it goes in
// that profile, NOT here with a later removal.

module.exports = (c) => {
    const darwin = c.facts.os.name === "darwin";

    // -----------------------------------------------------------------------
    // Directories (must exist before symlinks land inside them)
    // -----------------------------------------------------------------------
    // Crucible's default dir mode is 0o700; ~/.config wants 0o755 so tools
    // running as other uids can traverse it.
    c.dir("~/.config", { mode: 0o755 });
    c.dir("~/.local/bin", { mode: 0o755 });
    c.dir("~/.ssh", { mode: 0o700 });

    // herdr: only config.toml is tracked — the dir also holds logs, sockets,
    // and sessions, so symlink the file and let the dir stay real.
    c.dir("~/.config/herdr", { mode: 0o755 });

    // -----------------------------------------------------------------------
    // Homebrew — libraries, compiled deps, system integration
    // -----------------------------------------------------------------------
    // Everything mise can own well lives in mise/config.toml instead. What
    // stays here has heavy dep graphs, or is load-bearing enough that a shim
    // misfire would be painful.
    if (darwin && c.facts.homebrew.available) {
        c.brew([
            // git is a DELIBERATE exception to the mise preference: it is the
            // osxkeychain credential-helper integration point and the one tool
            // that must never be broken by a shim.
            "git",
            "gnupg",
            "cmake",
            "ninja",
            "mkcert",
            "postgresql@14",
            "cloudflared",
            "mas",
            "pup",
        ]);

        // --- Removals: LSPs now owned by Mason -----------------------------
        // nvim/lua/plugins/lsp.lua already ensure_installed's these, and
        // ~/.local/share/nvim/mason/bin already contains its own copies.
        // efm-langserver and clojure-lsp are in NEITHER Mason nor
        // ensure_installed, and efm has no config in lsp.lua — orphaned.
        c.brew([
            "bash-language-server",
            "lua-language-server",
            "terraform-ls",
            "typescript",
            "efm-langserver",
            "clojure-lsp",
        ], { state: "absent" });

        // --- Removals: brew/mise duplicates --------------------------------
        // ⚠️ PREREQUISITE: the PATH fix must land FIRST. Today brew wins on
        // PATH (mise activate does not prepend a shims dir), so removing these
        // before mise actually resolves leaves you with no nvim/rg/bat.
        // See TODO.md "PATH fix" — do it as its own change, verify with
        // `command -v nvim` pointing into ~/.local/share/mise, then enable this.
        //
        // Verified with `brew uses --installed --recursive`: only tmuxinator
        // depended on any of these (on tmux), and tmuxinator is dropped.
        c.brew([
            "fzf",
            "neovim",
            "ripgrep",
            "bat",
            "git-delta",
            "starship",
            "tmux",
            "tmuxinator",
            "awscli",
        ], { state: "absent" });

        // --- Removals: deprecated / dead -----------------------------------
        // python@3.9 and 3.10 are both EOL. See TODO.md — open question
        // whether Python should come from mise instead.
        c.brew(["python@3.9", "python@3.10"], { state: "absent" });
    }

    // -----------------------------------------------------------------------
    // Casks — shared applications
    // -----------------------------------------------------------------------
    if (darwin && c.facts.homebrew.available) {
        c.brew([
            // terminals / editors
            "iterm2",
            "ghostty",          // config + $TERMINAL already assume it; app was MISSING
            "visual-studio-code",
            // browsers
            "firefox",
            "google-chrome",
            // input / system
            "karabiner-elements",
            "bettertouchtool",
            "stats",
            "raycast",
            // fonts
            "font-hack-nerd-font",
            // utilities
            "1password-cli",
            "docker-desktop",
            "obsidian",
            // communication / media / notes — wanted on BOTH profiles
            "discord",
            "spotify",
            "notion",
            "dropbox",
            // AI tooling
            "claude",       // desktop app; the CLI comes from scripts.js
            "cursor",
            "ollama",
            "zed",
        ]);

        // NOT WANTED — logseq.
        // It is currently installed as a cask, and unlike c.script() brew DOES
        // support removal, so this actively uninstalls it. Drop this line if you
        // would rather just leave it installed and stop managing it.
        c.brew(["logseq"], { state: "absent" });
    }

    // -----------------------------------------------------------------------
    // Shell / dotfile symlinks — direct port of symlink.sh
    // -----------------------------------------------------------------------
    // ⚠️ SAFETY DIFFERENCE FROM symlink.sh: its symlink_dir() REFUSED when the
    // target existed and was not a symlink. c.symlink() does the opposite — it
    // plans a destructive delete, prompts a second time, and does NOT back up.
    // On a machine with a real ~/.config/nvim directory this will offer to
    // delete it. Read the plan before confirming.
    //
    // Symlink targets are stored verbatim, so they must be absolute or
    // home-relative — a bare "nvim" would dangle. Verified: expandPath() turns
    // a leading "~/" into the target dir for BOTH path and target, so the
    // "~/src/..." form below resolves correctly and stays username-agnostic.
    const dots = "~/src/github.com/bkegley/dotfiles";

    // Umbrella directories
    c.symlink("~/.config/shell", { target: `${dots}/shell` });
    c.symlink("~/.config/ghostty", { target: `${dots}/ghostty` });
    c.symlink("~/.config/zellij", { target: `${dots}/zellij` });
    c.symlink("~/.config/nvim", { target: `${dots}/nvim` });
    c.symlink("~/.config/tmux", { target: `${dots}/tmux` });
    c.symlink("~/.config/mise", { target: `${dots}/mise` });

    // Files
    c.symlink("~/.zshrc", { target: `${dots}/zsh/.zshrc` });
    c.symlink("~/.gitconfig", { target: `${dots}/git/.gitconfig` });
    c.symlink("~/.gitignore_global", { target: `${dots}/git/.gitignore_global` });
    c.symlink("~/.config/starship.toml", { target: `${dots}/starship/starship.toml` });
    c.symlink("~/.config/herdr/config.toml", { target: `${dots}/herdr/config.toml` });

    // macOS-only. Note the source dir is misspelled "karibener" in the repo.
    if (darwin) {
        c.symlink("~/.config/karabiner", { target: `${dots}/karibener` });
    }

    // --- Cruft: stale symlinks that should not survive a migration ---------
    // ~/.tmux.conf is superseded by ~/.config/tmux.
    c.symlink("~/.tmux.conf", { state: "absent" });

    // -----------------------------------------------------------------------
    // oh-my-zsh — required by zsh/.zshrc line 1
    // -----------------------------------------------------------------------
    // Ordering caveat: nothing guarantees this clone completes before the
    // .zshrc symlink lands. Both will exist after one apply, but a brand-new
    // machine's first interactive shell may run before this finishes. Harmless
    // — the second pass settles it.
    c.git("~/.oh-my-zsh", {
        url: "https://github.com/ohmyzsh/ohmyzsh.git",
        branch: "master",
    });

    // -----------------------------------------------------------------------
    // macOS defaults — only what is deliberately customized on this machine
    // -----------------------------------------------------------------------
    // The broader "standard macOS setup script" set is deliberately NOT here.
    // See TODO.md open question #7.
    if (darwin) {
        // Keyboard — much faster than stock (defaults are 68 / 6)
        c.defaults("NSGlobalDomain", "InitialKeyRepeat", 15);
        c.defaults("NSGlobalDomain", "KeyRepeat", 2);

        // Text input — every smart-substitution feature off. All five are
        // explicitly set to 0 on this machine (macOS defaults them on), which
        // reads as a deliberate "stop rewriting what I type".
        c.defaults("NSGlobalDomain", "NSAutomaticSpellingCorrectionEnabled", false);
        c.defaults("NSGlobalDomain", "NSAutomaticCapitalizationEnabled", false);
        c.defaults("NSGlobalDomain", "NSAutomaticDashSubstitutionEnabled", false);
        c.defaults("NSGlobalDomain", "NSAutomaticQuoteSubstitutionEnabled", false);
        c.defaults("NSGlobalDomain", "NSAutomaticPeriodSubstitutionEnabled", false);

        // Trackpad — tap to click (macOS default is 0, i.e. physical click only)
        c.defaults("com.apple.AppleMultitouchTrackpad", "Clicking", true);
        c.defaults("com.apple.driver.AppleBluetoothMultitouch.trackpad", "Clicking", true);

        // Mission Control — do NOT reorder Spaces by most-recent-use. Keeps
        // Space positions stable, which matters if you navigate by index.
        c.defaults("com.apple.dock", "mru-spaces", false);

        // Hot corner: bottom-right = Quick Note (14). The other three corners
        // are unset (no action), matching the macOS default.
        //
        // Note: wvous-br-modifier is genuinely UNSET on this machine, so it is
        // deliberately not declared — setting it to 0 would be inventing state.
        c.defaults("com.apple.dock", "wvous-br-corner", 14);

        // Menu bar clock — show AM/PM and day of week.
        c.defaults("com.apple.menuextra.clock", "ShowAMPM", true);
        c.defaults("com.apple.menuextra.clock", "ShowDayOfWeek", true);

        c.defaults("NSGlobalDomain", "AppleInterfaceStyle", "Dark");
        c.defaults("com.apple.finder", "FXPreferredViewStyle", "Nlsv");

        c.defaults("com.apple.dock", {
            autohide: true,
            tilesize: 44,
            largesize: 128,
        });
    }

    // -----------------------------------------------------------------------
    // Deliberately NOT declared — see PROPOSAL.md for the reasoning
    // -----------------------------------------------------------------------
    // c.dock()      — your persistent-apps is the stock Apple set; you autohide
    //                 the Dock and use Raycast. Declaring it means inventing a
    //                 layout you do not currently have.
    // c.keyRemap()  — hidutil UserKeyMapping is (null). Caps Lock is handled by
    //                 Karabiner doing Hyper-or-Escape-if-tapped PLUS a
    //                 caps+ijkl arrow layer. c.keyRemap() only does flat
    //                 modifier→modifier swaps and would FIGHT Karabiner.
    // c.display()   — nothing customized (NSTableViewDefaultSizeMode unset).
    // c.font()      — no loose font files; font-hack-nerd-font is a cask.
    // c.mas()       — `mas list` returns EMPTY despite Xcode/Paprika being App
    //                 Store apps. Unusable until that is explained.
    // c.mise()      — mise/config.toml is symlinked instead. c.mise() cannot
    //                 express [settings] or trusted_config_paths, so porting
    //                 would mean maintaining a split file.
    // c.shell()     — $SHELL is already /bin/zsh; brew zsh is not installed.
};
