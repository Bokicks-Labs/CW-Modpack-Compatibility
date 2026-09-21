# CW Audio Mixer

`CWAudioMixer` is an optional, client-only submod in the Chaosworld Compatibility Workshop item. Enable it after `CWModpackCompatibility`; it changes neither server state nor save data.

Open it from **Mod Options > CW Audio Mixer**, or by right-clicking the world and selecting **CW Audio Mixer**.

At game start it discovers every loaded `GameSound` and groups them using the sound's declared category/master plus cautious name matching. The group sliders range from 0% to 200%. Select a discovered sound to preview it, adjust it independently, or assign it to a different group. Settings are saved locally in `%UserProfile%\Zomboid\CWAudioMixer.ini`.

The **Restore originals** button returns all discovered sound volumes to their values before the mixer first adjusted them and clears custom group assignments.

## Scope and limitation

The mod uses Project Zomboid's public per-sound user-volume API. It does not modify FMOD banks or base-game files. Vanilla rain is a layer inside the combined `World/Ambiance` FMOD event, so Build 42 does not expose a reliable rain-only volume control to Lua. Use **World ambience** to reduce it; that also changes other weather and ambient layers.

For multiplayer, each player chooses their own local mixer settings. The mod has no server Lua, networking, sandbox options, or save writes.
