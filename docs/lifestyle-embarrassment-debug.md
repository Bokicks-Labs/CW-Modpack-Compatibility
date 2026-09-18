# Lifestyle embarrassment debug control

CW extends Lifestyle's existing world context menu:

**Right-click in the world > Lifestyle Debug Options > Character LS Needs > Embarrassment**

- **Increase (lshift - max)** adds 0.2; hold Left Shift to set 1.
- **Decrease (lshift - min)** subtracts 0.2; hold Left Shift to set 0.
- **Get Current** displays the current value.
- **Clear Embarrassment** sets the value and level to 0 immediately.

The existing Lifestyle permissions apply: debug mode in single player, or admin/debug-context capability in multiplayer. Only the selected local player's `LSMoodles.Embarrassed` entry changes. Other moodles, stress, unhappiness, cooldowns, and skills remain intact. The entry is initialized from Lifestyle's own properties if missing. Values stay between 0 and 1, and levels use Lifestyle's existing thresholds.

This provides manual recovery; it does not establish or fix the cause of persistent embarrassment. Restart the client to load the new Lua file. Gameplay verification remains required: open the menu, set/increase embarrassment, clear it, check that the icon disappears, then rejoin to check persistence.

Validated headlessly under Lua 5.1 with the installed Lifestyle `AdminTestCM.lua` and `MoodleProperties.lua`: original vanilla stat controls retained, no changes while opening the menu, clear/value limits/Shift endpoints, missing-entry initialization, permission checks, and preservation of other moodles and cooldowns. Native context-menu rendering and multiplayer persistence remain unverified.
