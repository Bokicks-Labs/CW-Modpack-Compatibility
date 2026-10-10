"""Static contract checks for the optional CW Audio Mixer submod."""
from pathlib import Path

from lupa import LuaRuntime


ROOT = Path(__file__).resolve().parent.parent
MOD_ROOT = ROOT / "Contents" / "mods" / "CWAudioMixer" / "42"
INFO = MOD_ROOT / "mod.info"
LUA = MOD_ROOT / "media" / "lua" / "client" / "CWAudioMixer.lua"
DOC = ROOT / "docs" / "audio-mixer.md"


def require(text: str, fragment: str) -> None:
    assert fragment in text, f"missing required contract: {fragment}"


def main() -> None:
    info = INFO.read_text(encoding="utf-8")
    lua = LUA.read_text(encoding="utf-8")
    doc = DOC.read_text(encoding="utf-8")

    require(info, "id=CWAudioMixer")
    require(info, "require=CWModpackCompatibility")
    require(info, "versionMin=42.20.0")
    require(lua, "GameSounds.getCategories")
    require(lua, "SystemDisabler.setEnableAdvancedSoundOptions(true)")
    require(lua, "Events.OnGameStart.Add(initialise)")
    require(lua, "function MainOptions:addSoundPanel()")
    require(lua, "Advanced sound mixer")
    require(lua, "function Mixer.restoreOriginalVolumes()")
    require(lua, "Weather and world ambience (includes vanilla rain)")
    require(lua, "Music and performances (not title-video audio)")
    require(lua, "function Mixer.panelGeometry(screenWidth, screenHeight)")
    require(lua, "function MixerPanel:prerender()")
    require(lua, "Death music (Game/GameOver)")
    require(lua, 'category == "ui"')
    require(lua, "getFileWriter(CONFIG_FILE, true, false)")
    assert "sendClientCommand" not in lua
    assert "sendServerCommand" not in lua
    require(doc, "does not modify FMOD banks")
    require(doc, "World/Ambiance")
    require(doc, "DeviceVolume")
    runtime_contract(lua)
    print("CW Audio Mixer static contracts passed.")


def runtime_contract(source: str) -> None:
    """Exercise the public mixer path with a tiny stand-in GameSounds registry."""
    lua = LuaRuntime(unpack_returned_tuples=True)
    lua.execute(
        """
        local callbacks = {}
        Events = {
            OnGameStart = { Add = function(fn) callbacks.start = fn end },
            OnMainMenuEnter = { Add = function(fn) callbacks.menu = fn end },
        }
        TestCallbacks = callbacks
        function require(_) return true end
        ISPanel = {
            derive = function(_, _) return {} end,
            new = function(_, x, y, width, height)
                return { x = x, y = y, width = width, height = height }
            end,
        }
        function getFileReader(_, _) return nil end
        function getFileWriter(_, _, _)
            return { write = function(_) end, close = function(_) end }
        end
        SystemDisabler = { setEnableAdvancedSoundOptions = function(value) TestAdvanced = value end }
        function getCore() return { getOptionFontSizeReal = function() return 1 end } end
        MainOptions = {
            style = { initialY = 8 },
            addSoundPanel = function(self) self.vanillaAudioBuilt = true end,
            close = function(self) self.closed = true end,
            onGameSounds = function(self) self.vanillaGameSoundsOpened = true end,
        }
        GameOption = { new = function(_, name, control)
            local option = { name = name, control = control }
            control.target = option
            control.targetFunc = function(target, _, value) target:onChange(control, value) end
            return option
        end }
        ISButton = { new = function(_, _, _, _, _, _, _, _)
            return { initialise = function() end, instantiate = function() end }
        end }

        local function list(values)
            return {
                size = function() return #values end,
                get = function(_, index) return values[index + 1] end,
            }
        end
        local function sound(name, category, master)
            return {
                name = name, category = category, master = master, volume = 1,
                getName = function(self) return self.name end,
                getCategory = function(self) return self.category end,
                getMasterName = function(self) return self.master end,
                getUserVolume = function(self) return self.volume end,
                setUserVolume = function(self, value) self.volume = value end,
            }
        end
        TestRadio = sound('RadioStatic', 'Object', 'Primary')
        TestProgram = sound('RadioTalk', 'Object', 'Primary')
        TestMusic = sound('MusicCombined', 'Music', 'Music')
        TestMenu = sound('UIToggleComboBox', 'UI', 'Primary')
        TestTV = sound('TelevisionStatic', 'Object', 'Primary')
        TestDeath = sound('PlayerDied', 'Player', 'Primary')
        TestWeather = sound('WorldAmbiance', 'World', 'Ambient')
        local byCategory = {
            Object = list({ TestRadio, TestProgram, TestTV }), Music = list({ TestMusic }),
            UI = list({ TestMenu }), Player = list({ TestDeath }), World = list({ TestWeather }),
        }
        GameSounds = {
            getCategories = function() return list({ 'Object', 'Music', 'UI', 'Player', 'World' }) end,
            getSoundsInCategory = function(category) return byCategory[category] end,
            getSound = function(name)
                if name == 'RadioStatic' then return TestRadio end
                if name == 'RadioTalk' then return TestProgram end
                if name == 'MusicCombined' then return TestMusic end
                if name == 'UIToggleComboBox' then return TestMenu end
                if name == 'TelevisionStatic' then return TestTV end
                if name == 'PlayerDied' then return TestDeath end
                if name == 'WorldAmbiance' then return TestWeather end
            end,
            saveINI = function() TestSaved = (TestSaved or 0) + 1 end,
            previewSound = function(_) end,
            stopPreview = function() end,
        }
        """
    )
    lua.execute(source)
    lua.execute("TestCallbacks.start()")
    assert lua.eval("TestAdvanced") is True
    assert lua.eval("CWAudioMixer.discovered['RadioTalk'] ~= nil") is True
    assert lua.eval("CWAudioMixer.discovered['UIToggleComboBox'] ~= nil") is True
    assert lua.eval("CWAudioMixer.settings.baseline['RadioTalk']") == 1

    lua.execute("CWAudioMixer.setGroupVolume('Radio', 2.5)")
    assert lua.eval("TestRadio.volume") == 0.5
    assert lua.eval("TestMusic.volume") == 1

    lua.execute("CWAudioMixer.setGroupVolume('MenuUI', 2.5)")
    assert lua.eval("TestMenu.volume") == 0.5
    lua.execute("CWAudioMixer.setGroupVolume('Music', 2.5)")
    assert lua.eval("TestMusic.volume") == 0.5
    lua.execute("CWAudioMixer.setGroupVolume('Death', 2.5)")
    assert lua.eval("TestDeath.volume") == 0.5
    lua.execute("CWAudioMixer.setGroupVolume('TV', 2.5)")
    assert lua.eval("TestTV.volume") == 0.5
    assert lua.eval("TestProgram.volume") == 0.5
    lua.execute("CWAudioMixer.setGroupVolume('Weather', 2.5)")
    assert lua.eval("TestWeather.volume") == 0.5

    lua.execute("""
        TestOptions = {
            width = 900, addY = 100, mainPanel = {
                addChild = function() end, insertNewLineOfButtons = function() end,
                setScrollHeight = function() end,
            },
            getWidth = function(self) return self.width end,
            addHorizontalLine = function(self) self.addY = self.addY + 20 end,
            addVolumeControl = function(self, _, _, _, _, label, value)
                self.addY = self.addY + 25
                return {
                    label = label, volume = value,
                    setVolume = function(control, newValue)
                        control.volume = newValue
                        if control.targetFunc then control.targetFunc(control.target, control, newValue) end
                    end,
                    getVolume = function(control) return control.volume end,
                }
            end,
            gameOptions = { options = {}, add = function(self, option) table.insert(self.options, option) end },
        }
        MainOptions.addSoundPanel(TestOptions)
    """)
    assert lua.eval("TestOptions.vanillaAudioBuilt") is True
    assert lua.eval("#TestOptions.gameOptions.options") == 9
    lua.execute("for _, option in ipairs(TestOptions.gameOptions.options) do option:toUI(); option:storeCurrentValue() end")
    lua.execute("TestOptions.gameOptions.options[3].control:setVolume(0)")
    assert lua.eval("TestTV.volume") == 0
    lua.execute("TestOptions.gameOptions.options[3]:restoreOriginalValue()")
    assert lua.eval("TestTV.volume") == 0.5

    lua.execute("CWAudioMixer.assignSound('RadioTalk', 'Music')")
    assert lua.eval("CWAudioMixer.settings.assignments['RadioTalk']") == "Music"
    assert lua.eval("TestProgram.volume") == 0.5

    lua.execute("CWAudioMixer.restoreOriginalVolumes()")
    assert lua.eval("TestRadio.volume") == 1
    assert lua.eval("next(CWAudioMixer.settings.assignments) == nil") is True

    lua.execute("""
        local lines = { 'group|Music|0.4', 'group|Devices|0.6', 'group|Menu|0.8',
            'group|World|0.2', 'base|TelevisionStatic|0.7',
            'assign|RadioTalk|Devices', 'assign|RadioStatic|Devices' }
        function getFileReader()
            local index = 0
            return {
                readLine = function() index = index + 1; return lines[index] end,
                close = function() end,
            }
        end
        luautils = { split = function(line, separator)
            local result = {}
            for part in (line .. separator):gmatch('(.-)' .. separator) do table.insert(result, part) end
            return result
        end }
        TestCallbacks.start()
    """)
    assert lua.eval("CWAudioMixer.settings.groups.Music") == 0.4
    assert lua.eval("CWAudioMixer.settings.groups.Radio") == 0.6
    assert lua.eval("CWAudioMixer.settings.groups.TV") == 0.6
    assert lua.eval("CWAudioMixer.settings.groups.MenuUI") == 0.8
    assert lua.eval("CWAudioMixer.settings.groups.Weather") == 0.2
    assert lua.eval("CWAudioMixer.settings.baseline.TelevisionStatic") == 0.7
    assert lua.eval("CWAudioMixer.settings.assignments.RadioTalk") == "TV"
    assert lua.eval("CWAudioMixer.settings.assignments.RadioStatic") == "Radio"

    for width, height in [(1920, 1080), (2560, 1440), (1280, 720)]:
        x, y, panel_width, panel_height, scale = lua.eval(
            f"CWAudioMixer.panelGeometry({width}, {height})"
        )
        assert x >= 16 and y >= 16
        assert x + panel_width <= width - 16
        assert y + panel_height <= height - 16
        if height == 1440:
            assert scale > 1.3 and panel_width > 800 and panel_height > 700

    lua.execute("TestOptions.isVisible = function() return false end")
    lua.execute("CWAudioMixer.panel = { optionsOwner = TestOptions, onClose = function(self) self.closed = true end }")
    lua.execute("MainOptions.close(TestOptions)")
    assert lua.eval("CWAudioMixer.panel.closed") is True
    assert lua.eval("TestOptions.closed") is True
    lua.execute("CWAudioMixer.panel.closed = false; MainOptions.onGameSounds(TestOptions)")
    assert lua.eval("CWAudioMixer.panel.closed") is True
    assert lua.eval("TestOptions.vanillaGameSoundsOpened") is True


if __name__ == "__main__":
    main()
