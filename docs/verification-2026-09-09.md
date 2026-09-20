# Compatibility review: 1.1.2

## Follow-up repair: 1.1.3

The 20:04 startup log provided fresh evidence for two load failures. Bandits loaded under
its Build 42 mod ID, `Bandits2`, while the compatibility hook checked `Bandits`, so the safe
container-loot replacement never installed. The hook and its Lua contract test now use the
installed mod ID.

The same log reported `unknown block type "//"` while parsing custom perks. Project
Zomboid's perk parser does not accept those explanatory comment lines, so they were removed
without changing any perk definition. Runtime confirmation is still required after a full
game restart: the safe-loot installation marker must appear and the Lifestyle skills must
be visible in the character panel.

## Evidence and change

The starting checkout was clean on `main` at `075d61ad9958ea0cffd259633e4bec2b869eb282` (1.1.1). Source, installed Workshop item 3797782198, and uploader staging each contained 427 identical SHA-256-verified files. The local mod junction targets repository source. No applicable local AGENTS.md was found in the repository or its ancestor directories.

The newest DebugLog and console.txt still end at September 9, 2026, 04:36:34 local time, before the reported 1.1.1 deployment. There is no newer gameplay evidence to evaluate error reduction, skill display, or freezes.

Installed Bandits `42.20/media/lua/shared/BanditPrograms.lua` defines `predicateAll` as a file-local function. CW's replacement could not access that function, so its nearby-container branch passed nil to `getAllEvalRecurse`. Version 1.1.2 supplies its own equivalent callback. Target distance, guards, animations, task duration, task coordinates, and movement behavior are unchanged.

The installed `GetMoveTask` accepts the existing nil endurance value; BanditUpdate guards `task.endurance` before using it. No endurance behavior was changed. AIWeekOne calls `BanditPrograms.Container.Loot` dynamically, so calls use the replacement after installation. No competing assignment was found in AIWeekOne or CW. OnGameStart/OnServerStarted registration and repeat-install protection were checked with mocks; actual event ordering and other enabled mods still require runtime confirmation.

## Lifestyle review

- All six original perk definitions match installed Lifestyle source; CW adds five mirrors.
- Installed ISCharacterInfo.loadPerk includes child perks regardless of the passive flag. The stale comment about a separate passive tab does not match that function's actual filter.
- HiddenSkills stores XP within the current level. Returning that value from the progress-bar bridge matches the base UI's expected within-level XP, and the mirror thresholds match HSMng.lua.
- Pool and Arcade are explicitly false in HiddenSkills.skills. Their display mirrors do not activate those features or grant XP.
- Existing-save initialization reads mod data and syncs mirror levels. The display option filters UI entries; it does not write earned hidden XP.
- Registration/load order and screen refresh remain unverified in game. No speculative Lifestyle changes were made.

## Validation

`Scripts/test-bandits-loot.py` uses Python's optional `lupa` package to execute the patch with Lua mocks. It verifies the callback, loot task fields, distant movement, blocked-tile handling, nil guards, disabled-mod behavior, and repeated event installation. The original 1.1.1 source fails the callback assertion; 1.1.2 passes. Both reviewed Lua files compile in the Lua runtime. These checks do not validate PZ's Java bridge, UI rendering, or NPC behavior.

For this run, lupa was installed only under `%TEMP%\cw-lua-validation`; set PYTHONPATH to that directory before running the test if using that copy.

## Deployment and rollback

PZ was not running at inspection. Backup captured before changes:

`C:\Users\Rim28\Zomboid\backups\cw-review-20260909-182524`

Subfolders `authoring`, `active`, and `workshop-staging` contain the respective complete 1.1.1 mod trees. Restore each corresponding tree while PZ is closed to roll back. The local testing junction exposes authoring changes directly, so source edits also require care during play.

The staging helper copies files and metadata but does not create backups or reject extra destination files. This run uses the explicit backup above and checks complete file sets and hashes separately. Staging is not publishing a Steam Workshop update.

## Next gameplay checks

1. On an existing save, confirm Art, Cleaning, Dancing, Meditation, and Music plus all five mirrors appear under Lifestyle with the display option enabled.
2. Perform yoga; compare its mirror level and progress against LSHiddenSkills.Yoga, including a level transition.
3. Toggle display off/on and reopen the skill panel; verify earned hidden XP remains unchanged. Pool and Arcade should remain inactive.
4. Confirm the safe-container-loot installation log, then let naturally encountered NPCs seek supplies. Check the fresh log for the original getX error and any new callback/loot exception.
5. Record the time of any freeze or sustained slowdown so its actual stack and workload can be examined. Earlier pathing/bone warnings alone do not prove a cause.
