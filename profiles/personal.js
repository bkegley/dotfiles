// Personal machine profile.
//
// Selected when ~/.crucible-work does NOT exist.

module.exports = (c) => {
    const darwin = c.facts.os.name === "darwin";

    if (darwin && c.facts.homebrew.available) {
        // -------------------------------------------------------------------
        // Personal-only applications
        // -------------------------------------------------------------------
        // discord / spotify / notion / dropbox moved to shared.js — they are
        // wanted on the work machine too, and shared is the right home for a
        // true intersection. Duplicating them per-profile would be harmless but
        // pointless, and risks drifting out of sync.
        c.brew([
            "anydo",
            "godot",
        ]);
    }

    // -----------------------------------------------------------------------
    // The games in ~/Applications (Balatro, Factorio, No Man's Sky, ...) are
    // Steam/itch installs with no cask, so they cannot be declared here.
    // -----------------------------------------------------------------------
};
