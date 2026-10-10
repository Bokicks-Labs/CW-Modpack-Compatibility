# CW Audio Mixer

`CWAudioMixer` is an optional, client-only submod in the Chaosworld Compatibility Workshop item. Enable it after `CWModpackCompatibility`; it changes neither server state nor save data.

The group controls appear directly under **Options > Audio > CW Audio Mixer**. Use **Advanced sound mixer** on that page to inspect, preview, change, and reassign individual sounds.

The mixer discovers loaded `GameSound` definitions and groups them into Menu UI, Death music, TV effects, Radio effects, Music, Weather and ambience, Vehicles, Combat, and Other. The Death music group controls `PlayerDied` (`Game/GameOver`), which PZ plays when all players are dead. The group sliders range from 0% to 200%. Settings are saved locally in `%UserProfile%\Zomboid\CWAudioMixer.ini`. Existing per-sound baselines and assignments are retained; older Music, Devices, Menu, World, and Main-menu background group levels migrate to the closest supported groups.

The **Restore originals** button returns all discovered sound volumes to their values before the mixer first adjusted them and clears custom group assignments.

## Scope and limitation

The mod uses Project Zomboid's public per-sound user-volume API. It does not modify FMOD banks or base-game files. **The loud title-screen thunder/rain/static is not controlled by this mixer.** The previous Main-menu background slider only changed `MusicCombined`/`Music/Main`; user testing found that none of the mixer sliders affected the background sound. Build 42 renders `title_screen_background.bik` through `VideoTexture`, which exposes no audio-volume method to Lua. The misleading slider was removed; `MusicCombined` now belongs to Music, and an old Main-menu background value is migrated there only when no Music setting exists. This establishes a public-API limit, not proof of the precise audio track inside the video. Vanilla rain is a layer inside the combined `World/Ambiance` FMOD event, so Build 42 does not expose a reliable rain-only volume control to Lua. Use **Weather and world ambience** to reduce it; that also changes other ambient layers.

The TV group controls discovered `Television*` sound effects, including static and on/off sounds, plus `RadioTalk`. PZ uses `RadioTalk` for the program loop on ordinary TVs **and radios**, so this slider also changes radio program audio. Broadcast loudness also depends on the device's own volume (`DeviceData` and FMOD `DeviceVolume`); set that on the TV or radio first. This control does not change an audio track embedded in a video.

For multiplayer, each player chooses their own local mixer settings. The mod has no server Lua, networking, sandbox options, or save writes.

## 1440p Advanced-panel layout fix

The Advanced panel formerly used a fixed 645×550 rectangle and hard-coded child coordinates. With the expanded group list, that made labels and controls cramped at 2560×1440. It now scales its rectangle **and every child coordinate/size together** from the game-reported screen height: 1× at 1080p, 1.33× at 1440p, capped at 1.4× and further limited to a 16-pixel viewport margin. It remains centered. The panel also closes when its Options parent closes or becomes invisible; Escape and its own Close button still work. The Lua contract harness checks geometry at 720p, 1080p, and 1440p plus the Options close paths; visual verification in a fresh game session remains pending. This is the reusable pattern for the proposed custom-menu 1440p submod: use one bounded layout scale and one owner-lifecycle rule for each popup, then verify the actual game font/UI-scale settings in a fresh session. Do not multiply only the outer window while leaving children at fixed coordinates.
