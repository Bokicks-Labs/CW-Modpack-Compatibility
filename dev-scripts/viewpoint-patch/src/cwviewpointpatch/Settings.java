package cwviewpointpatch;

import se.krka.kahlua.integration.annotations.LuaMethod;

public final class Settings {
    public static volatile int menuMaxWidth = 600;

    private Settings() {}

    @LuaMethod(name = "CWViewpointSetMenuMaxWidth", global = true)
    public static void setMenuMaxWidth(int width) {
        menuMaxWidth = Math.max(360, Math.min(900, width));
    }
}
