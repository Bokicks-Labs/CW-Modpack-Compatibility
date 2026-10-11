package cwviewpointpatch;

import me.zed_0xff.zombie_buddy.Patch;

/** Viewpoint 0.1.6 truncates labels in LootPanel.label before measuring panel width. */
@Patch(className = "viewpoint.interact.LootPanel", methodName = "fit", warmUp = true)
public class MenuWidth {
    @Patch.OnEnter
    public static void enter(@Patch.Argument(value = 2, readOnly = false) int availableWidth) {
        availableWidth += Settings.menuMaxWidth - 360;
    }
}
