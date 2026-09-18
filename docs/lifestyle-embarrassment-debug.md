# Lifestyle embarrassment debug control

CW adds a direct item at the top of the world context menu, opening a movable window instead of cascading submenus:

**Right-click in the world > Lifestyle: Embarrassment Controls**

- **Increase +0.2** adds 0.2.
- **Decrease -0.2** subtracts 0.2.
- **Set Maximum (1)** sets the value to 1.
- **Clear Embarrassment** sets the value and level to 0 immediately.
- The current value and level update in the window while it is open.
- **Close** or the window's close button dismisses it. Reopening replaces the previous window for that local player.

The existing Lifestyle permissions apply: debug mode in single player, or admin/debug-context capability in multiplayer. Only the selected local player's `LSMoodles.Embarrassed` entry changes. Other moodles, stress, unhappiness, cooldowns, and skills remain intact. The entry is initialized from Lifestyle's own properties if missing. Values stay between 0 and 1, and levels use Lifestyle's existing thresholds.

This provides manual recovery; it does not establish or fix the cause of persistent embarrassment. Restart the client to load the new Lua file. Gameplay verification remains required: open the menu, set/increase embarrassment, clear it, check that the icon disappears, then rejoin to check persistence.

The window avoids the reported overlap when traversing deeply nested context menus. It does not change positioning of other game/mod submenus. Button dimensions account for the configured small-font size.

Validated the replacement under Lua 5.1 using Lifestyle's installed moodle properties and the game's actual window constructor/title-bar sizing/close method, with native widgets and drawing mocked: direct access without submenus, live value display, all five buttons, limits and levels, permission/dead-player/context-probe guards, isolated initialization, close/reopen behavior, and large-font button geometry. Native rendering, dragging and multiplayer persistence require an in-game check.
