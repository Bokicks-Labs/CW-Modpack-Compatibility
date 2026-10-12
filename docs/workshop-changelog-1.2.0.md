# Version 1.2.0

Changes since the October 9, 2026 Steam Workshop update (live description listed 1.1.15).

See the [plain-text Steam release notes](steam-changelog-1.2.0.txt) for the complete changelog.

```text
Chaosworld B42 Modpack Compatibility
Version 1.2.0 - Workshop release notes
Changes since the October 9, 2026 Steam Workshop update (live description listed 1.1.15)

ADDED
- Optional CW Viewpoint Patch (0.2.0) for Build 42.21+: adjustable Viewpoint loot/interaction-menu width, Project A-Life NPC interaction targets, and a guarded world right-click fallback. Requires Viewpoint and ZombieBuddy and must be enabled separately; its optional behaviors should be verified with your own Viewpoint setup.
- Optional Casualties Undead compatibility: when the Health panel's Cheat switch is enabled, Full health and Full health (body) are accessible at the top of the body-part context menu. Normal treatments are unchanged.
- Distinct icon/poster artwork for the Workshop submods.

FIXED
- Keep the duplicate vanilla Moodle UI hidden if Build 42 repositions it after Moodles in Lua takes ownership.
- Place Casualties Undead's custom moodles after visible vanilla and Moodle Framework entries, including when Moodles in Lua owns vanilla rendering.
- Reserve separate stack rows for active Lifestyle and Infirmities Moodle Framework moodles, including when MoodlePriority is enabled.
- Improve Mod Options Search navigation when a search result refers to a heading or description without its own setting control; show a message if a jump target is unavailable.
- Restore the intended default division of hygiene responsibilities: CW can neutralize Lifestyle's own personal hygiene meter and clear its clean/dirty moodles without disabling Lifestyle cleaning actions or its Cleaning skill. Nature's Call and Brush Your Damn Teeth ownership remain separate.

IMPROVED
- CW Audio Mixer: more granular groups for menu/UI, death music, television, radio, music, weather/ambience, vehicles, combat, and other sounds; expanded per-sound controls, saved-settings migration, restore-originals behavior, and scalable Advanced-panel layout.
- Clarify that title-screen video audio has no reliable mixer control and that the shared vanilla world-ambience event does not provide a true rain-only slider.
- More complete documentation, mod inventory/reference guides, diagnostic instructions, and staging guidance.

CHANGED
- The discontinued bundled ZombieBuddy setup/JAR package has been removed. Install ZombieBuddy from its official Steam Workshop item (3619862853) and follow upstream installation instructions. An existing working native DLL should not be overwritten solely as part of cleanup.
- Viewpoint 0.1.6 makes some older third-party car/menu fix add-ons obsolete; inspect saved mod lists and back up saves before removing any add-on. CW does not automatically migrate saves.
- CW Mod Options Search: 0.1.1 -> 0.1.2 (search-navigation fix).
- CW Audio Mixer: 0.1.0 -> 0.2.0 (expanded controls).
- CW Viewpoint Patch: remains 0.2.0 (first Workshop release).
- Core compatibility mod: 1.1.15 in the last Workshop description -> 1.2.0.

INSTALLATION / SAFETY
- The core mod supports Build 42.20+; CW Viewpoint Patch requires Build 42.21+.
- Load CWModpackCompatibility after the mods it patches, near the end of the mod list. Enable each optional submod separately; load CWViewpointPatch after Viewpoint.
- Install original upstream mods for any features you use. CW is a compatibility layer, not a replacement.
- Restart both game and server after changing mods, order, or Lifestyle ownership settings; keep multiplayer client/server mod lists synchronized.
- Back up important saves before changing mod lists.
- The optional Viewpoint patch ships a client-side Java JAR, which requires a deliberate ZombieBuddy approval; it does not install or change upstream JARs, DLLs or game executables.
- Developer-only CWBanditsPerfTest is not part of this Workshop upload.

RELEASE STATUS
- The Casualties Undead stack placement was checked with Lua mocks for Moodles in Lua and vanilla MoodleUI plus Moodle Framework. In-game placement and other multiplayer combinations were not retested for this release preparation.
- Before publishing: inspect Workshop staging, confirm the release metadata and selected optional submods, and upload manually via Project Zomboid's Workshop publisher. Run the repository's focused checks if further changes are made.
```
