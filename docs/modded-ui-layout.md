# Modded UI layout

`CWModdedUILayout` is an optional client submod for UI fixes in other mods. It currently requires Casualties Undead and adjusts three affected surfaces from the 2560x1440 screenshots: the health panel's attached Vitals report, the debug control window, and the Vitals column shared by treatment minigames.

The patch widens the Vitals report from 268 to 344 pixels, increases its labelled-row spacing, and moves its To-Do button with the new right edge. The debug window uses two columns sized from the longest button label and retains its scroll view. The minigame monitor fraction grows from 0.30 to 0.40, and its bars sit farther below their labels. The minigame's opening size calculation still limits the full window to the available screen width. These are display changes only; treatment and debug commands retain their original handlers.

Enable this submod after Casualties Undead. Test with readable in-game text size, first in a disposable save. Compare the health report, debug menu, and two different treatment minigames. Check long debug labels, the Vitals organ list, minigame sidebar labels, and the case event log for clipping or overlap. The supplied screenshots are sufficient for the first patch; additional minigame screenshots are useful only if a distinct layout issue remains after testing.
