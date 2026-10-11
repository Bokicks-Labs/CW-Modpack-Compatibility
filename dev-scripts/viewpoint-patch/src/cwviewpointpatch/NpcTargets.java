package cwviewpointpatch;

import java.lang.reflect.Method;
import java.util.List;
import me.zed_0xff.zombie_buddy.Patch;

/** Add A-Life NPC shells to the same Viewpoint PERSON pick list as other players. */
@Patch(className = "viewpoint.interact.LootTargets", methodName = "people", warmUp = true)
public class NpcTargets {
    private static Access access;
    private static boolean unavailableLogged;

    @Patch.OnExit
    public static void exit(@Patch.Argument(0) Object player, @Patch.Argument(1) Object center) {
        addNpcTargets(player, center);
    }

    // Advice is copied into Viewpoint's package; keep the call target public.
    public static void addNpcTargets(Object player, Object center) {
        if (player == null || center == null) return;
        try {
            Access a = access;
            if (a == null) {
                synchronized (NpcTargets.class) {
                    if (access == null) access = new Access();
                    a = access;
                }
            }
            Object cell = a.playerCell.invoke(player);
            int cx = ((Number) a.squareX.invoke(center)).intValue();
            int cy = ((Number) a.squareY.invoke(center)).intValue();
            int cz = ((Number) a.squareZ.invoke(center)).intValue();
            for (int dy = -2; dy <= 2; dy++) {
                for (int dx = -2; dx <= 2; dx++) {
                    Object square = a.cellSquare.invoke(cell, cx + dx, cy + dy, cz);
                    if (square == null) continue;
                    Object moving = a.movingObjects.invoke(square);
                    if (!(moving instanceof List<?> objects)) continue;
                    for (Object object : objects) {
                        if (!a.zombieType.isInstance(object)
                                || Boolean.TRUE.equals(a.isDead.invoke(object))
                                || !Boolean.TRUE.equals(a.canSee.invoke(player, object))) continue;
                        Object data = a.modData.invoke(object);
                        if (data == null || !Boolean.TRUE.equals(a.rawget.invoke(data, "ProjectALifeOwned"))) continue;
                        Object uid = a.rawget.invoke(data, "ProjectALifeUID");
                        if (uid == null || uid.toString().isEmpty()) continue;
                        float x = ((Number) a.objectX.invoke(object)).floatValue();
                        float y = ((Number) a.objectY.invoke(object)).floatValue();
                        float z = ((Number) a.objectZ.invoke(object)).floatValue() * 2.4494896f;
                        int index = ((Number) a.add.invoke(null, 6, null, object)).intValue();
                        if (index >= 0) a.grow.invoke(null, index,
                                x - 0.3f, y - 0.3f, z, x + 0.3f, y + 0.3f, z + 1.6f);
                    }
                }
            }
        } catch (Throwable failure) {
            if (!unavailableLogged) {
                unavailableLogged = true;
                System.err.println("[CWViewpointPatch] NPC target bridge unavailable: " + failure);
            }
        }
    }

    private static final class Access {
        final Class<?> zombieType;
        final Method playerCell, squareX, squareY, squareZ, cellSquare, movingObjects;
        final Method isDead, canSee, modData, rawget, objectX, objectY, objectZ, add, grow;

        Access() throws ReflectiveOperationException {
            Class<?> player = Class.forName("zombie.characters.IsoPlayer");
            Class<?> square = Class.forName("zombie.iso.IsoGridSquare");
            Class<?> object = Class.forName("zombie.iso.IsoObject");
            Class<?> moving = Class.forName("zombie.iso.IsoMovingObject");
            Class<?> cell = Class.forName("zombie.iso.IsoCell");
            zombieType = Class.forName("zombie.characters.IsoZombie");
            Class<?> table = Class.forName("se.krka.kahlua.vm.KahluaTable");
            Class<?> targets = Class.forName("viewpoint.interact.LootTargets");
            Class<?> boxes = Class.forName("viewpoint.interact.LootBoxes");
            playerCell = player.getMethod("getCell");
            squareX = square.getMethod("getX");
            squareY = square.getMethod("getY");
            squareZ = square.getMethod("getZ");
            cellSquare = cell.getMethod("getGridSquare", int.class, int.class, int.class);
            movingObjects = square.getMethod("getMovingObjects");
            isDead = zombieType.getMethod("isDead");
            canSee = player.getMethod("CanSee", moving);
            modData = zombieType.getMethod("getModData");
            rawget = table.getMethod("rawget", Object.class);
            objectX = zombieType.getMethod("getX");
            objectY = zombieType.getMethod("getY");
            objectZ = zombieType.getMethod("getZ");
            add = targets.getDeclaredMethod("add", int.class, square, object);
            add.setAccessible(true);
            grow = boxes.getDeclaredMethod("grow", int.class, float.class, float.class, float.class,
                    float.class, float.class, float.class);
            grow.setAccessible(true);
        }
    }
}
