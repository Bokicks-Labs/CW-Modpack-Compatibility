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
    require(lua, "Events.OnFillWorldObjectContextMenu.Add(addContextOption)")
    require(lua, "function Mixer.restoreOriginalVolumes()")
    require(lua, "World ambience (includes vanilla rain)")
    require(lua, "getFileWriter(CONFIG_FILE, true, false)")
    assert "sendClientCommand" not in lua
    assert "sendServerCommand" not in lua
    require(doc, "does not modify FMOD banks")
    require(doc, "World/Ambiance")
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
            OnFillWorldObjectContextMenu = { Add = function(fn) callbacks.context = fn end },
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
        TestRadio = sound('RadioTalk', 'Object', 'Primary')
        TestMusic = sound('MusicCombined', 'Music', 'Music')
        local byCategory = { Object = list({ TestRadio }), Music = list({ TestMusic }) }
        GameSounds = {
            getCategories = function() return list({ 'Object', 'Music' }) end,
            getSoundsInCategory = function(category) return byCategory[category] end,
            getSound = function(name)
                if name == 'RadioTalk' then return TestRadio end
                if name == 'MusicCombined' then return TestMusic end
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
    assert lua.eval("CWAudioMixer.settings.baseline['RadioTalk']") == 1

    lua.execute("CWAudioMixer.setGroupVolume('Devices', 2.5)")
    assert lua.eval("TestRadio.volume") == 0.5
    assert lua.eval("TestMusic.volume") == 1

    lua.execute("CWAudioMixer.assignSound('RadioTalk', 'Music')")
    assert lua.eval("CWAudioMixer.settings.assignments['RadioTalk']") == "Music"
    assert lua.eval("TestRadio.volume") == 1

    lua.execute("CWAudioMixer.restoreOriginalVolumes()")
    assert lua.eval("TestRadio.volume") == 1
    assert lua.eval("next(CWAudioMixer.settings.assignments) == nil") is True


if __name__ == "__main__":
    main()
