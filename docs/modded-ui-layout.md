# Modded UI layout

`CWModdedUILayout` is an optional client submod for UI fixes in other mods. Version 0.1.0 requires Casualties Undead. Enable it after Casualties Undead; it does not require the CW core.

It adjusts the Health panel's attached Vitals report, the debug control window, and the Vitals and case sidebar shared by treatment minigames. The Vitals report is wider, with taller headers and more space between readings. The debug menu uses two columns sized to its longest button label and remains scrollable. The minigame monitor is wider; its case sidebar separates SITE, injury tags, and the event log into distinct rows. Text is measured before placement so timestamps, panel edges, and bottom progress and quality bars have room.

The changes affect display only. Casualties Undead still handles treatments, minigames, and debug commands. The source Workshop mod is not modified. At 2560x1440, the layout was iterated against in-game screenshots of the Health panel, debug window, and dressing and tourniquet minigames. Other resolutions, languages, and minigames have not all been checked in game.

For a different text size or resolution, check the Health Vitals report, debug labels, and a treatment minigame with several case events. Report any clipped text with a screenshot and the game resolution and text-size setting.
