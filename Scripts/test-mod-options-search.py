"""Static contracts for the optional CW Mod Options Search submod."""
from pathlib import Path
from lupa import LuaRuntime

ROOT = Path(__file__).resolve().parent.parent
MOD_ROOT = ROOT / "Contents" / "mods" / "CWModOptionsSearch" / "42"
INFO = (MOD_ROOT / "mod.info").read_text(encoding="utf-8")
LUA = (MOD_ROOT / "media" / "lua" / "client" / "CWModOptionsSearch.lua").read_text(encoding="utf-8")
DOC = (ROOT / "docs" / "mod-options-search.md").read_text(encoding="utf-8")

def require(text: str, fragment: str) -> None:
    assert fragment in text, f"missing required contract: {fragment}"

def main() -> None:
    require(INFO, "id=CWModOptionsSearch")
    require(INFO, "require=CWModpackCompatibility")
    require(INFO, "versionMin=42.20.0")
    require(INFO, "modversion=0.1.2")
    require(LUA, 'require "OptionScreens/MainOptions"')
    require(LUA, "MainOptions.close = function")
    require(LUA, 'api:create("CWModOptionsSearch", "Mod Options Search")')
    require(LUA, "table.insert(api.Data, 1, options)")
    require(LUA, "PZAPI.ModOptions.Data")
    require(LUA, "panel:setYScroll(-wanted)")
    require(LUA, "string.find(result.searchText, query, 1, true)")
    require(LUA, "if #query < 2 then")
    require(LUA, "if MainOptions.__cwModOptionsSearchInstalled then return end")
    assert "PZAPI.ModOptions:save" not in LUA
    assert "sendClientCommand" not in LUA
    assert "sendServerCommand" not in LUA
    assert "child:setY" not in LUA
    assert "getText, tostring(value)" not in LUA
    require(DOC, "does not change option values")
    require(DOC, "does not expose a public hook")
    compiled = LuaRuntime(unpack_returned_tuples=True).eval("load")(LUA)
    if isinstance(compiled, tuple):
        compiled, error = compiled
        assert compiled is not None, error
    assert compiled is not None, "Lua source did not compile"
    runtime_contract(LUA)
    print("CW Mod Options Search static contracts passed.")

def runtime_contract(source: str) -> None:
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.execute(
        """
        function require(_) return true end
        UIFont = { Small = 1 }
        function getText(_) error('search index must not call getText') end
        function getTextManager() return { getFontHeight = function() return 12 end } end
        ISCollapsableWindow = {
            derive = function(_, _) return {} end,
            new = function() return {} end,
        }
        ISButton = { new = function() return {} end }
        MainOptions = { close = function() TestOriginalCloseCalls = (TestOriginalCloseCalls or 0) + 1 end }
        PZAPI = { ModOptions = { Data = {
            {
                name = 'Example Mod',
                data = {
                    { type = 'tickbox', name = 'UI_Enable_Feature', tooltip = 'Controls feature at 75%', element = { y = 123 } },
                    { type = 'description', text = 'Detailed searchable words (100%)' },
                    { type = 'tickbox', name = 'Later setting', element = { y = 456 } },
                    { type = 'title', name = 'Section after setting' },
                },
            },
        } } }
        function PZAPI.ModOptions:getOptions(id)
            for _, options in ipairs(self.Data) do
                if options.modOptionsID == id then return options end
            end
        end
        function PZAPI.ModOptions:create(id, name)
            local options = { modOptionsID = id, name = name, data = {}, dict = {} }
            function options:getOption(optionID) return self.dict[optionID] end
            function options:addButton(optionID, name, tooltip, onclick)
                local option = { type = 'button', id = optionID, name = name, tooltip = tooltip, onclick = onclick }
                table.insert(self.data, option)
                self.dict[optionID] = option
            end
            table.insert(self.Data, options)
            return options
        end
        """
    )
    lua.execute(source)
    assert lua.eval("MainOptions.__cwModOptionsSearchInstalled") is True
    assert lua.eval("PZAPI.ModOptions.Data[1].modOptionsID") == "CWModOptionsSearch"
    assert lua.eval("PZAPI.ModOptions.Data[1]:getOption('OPEN_SEARCH') ~= nil") is True
    assert lua.eval("#CWModOptionsSearch.buildIndex()") == 5
    assert lua.eval("CWModOptionsSearch.buildIndex()[2].targetY") == 123
    assert lua.eval("CWModOptionsSearch.buildIndex()[3].targetY") == 456
    assert lua.eval("CWModOptionsSearch.buildIndex()[5].targetY") == 456
    assert lua.eval("string.find(CWModOptionsSearch.buildIndex()[3].searchText, 'searchable', 1, true) ~= nil") is True
    assert lua.eval("string.find(CWModOptionsSearch.buildIndex()[2].searchText, 'enable feature', 1, true) ~= nil") is True
    assert lua.eval("string.find(CWModOptionsSearch.buildIndex()[2].searchText, '75%', 1, true) ~= nil") is True
    lua.execute(
        """
        TestWindow = { closed = false, close = function(self) self.closed = true end }
        CWModOptionsSearch.window = TestWindow
        MainOptions:close()
        """
    )
    assert lua.eval("TestWindow.closed") is True
    assert lua.eval("CWModOptionsSearch.modPanel == nil") is True
    assert lua.eval("TestOriginalCloseCalls") == 1

if __name__ == "__main__":
    main()
