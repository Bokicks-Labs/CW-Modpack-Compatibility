# Preserved environment and evidence manifest

Captured on the dedicated server machine on 2026-09-10 (America/New_York). No evidence file was deleted or modified during this investigation.

## Installation and active profile

- Dedicated server root: `C:\GameServers\ProjectZomboid`
- Active integration profile: `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP`
- Active config: `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\Server\CWDayOneMP.ini`
- Dedicated server build: 42.20.4, revision `b0bbce05d5`
- Current config: 247 `Mods` entries and 219 `WorkshopItems` entries
- Relevant enabled order: `Bandits2;CWModpackCompatibility;BanditsWeekOne;BanditsWeekOneCommandWheel`
- `DoLuaChecksum=false`, `Public=false`, `MaxPlayers=8`
- No Project Zomboid server Java process was running at capture time.

## Installed relevant Workshop artifacts

| Workshop ID | Mod ID | Installed content | Steam manifest | Workshop update time (ET) |
|---:|---|---|---:|---|
| 3268487204 | `Bandits2` | `mods/Bandits/42.20` | 6289354323690755129 | 2026-08-25 14:38:27 |
| 3403180543 | `BanditsWeekOne` | `mods/BanditsWeekOne/42.20` | 8876576871055314982 | 2026-08-07 15:39:08 |
| 3791829599 | `BanditsWeekOneCommandWheel` | `mods/BanditsWeekOneCommandWheel/42` | 5553584680169448264 | 2026-09-07 11:25:02 |
| 3797782198 | `CWModpackCompatibility` | `mods/CWModpackCompatibility/42`, modversion 1.1.5 | 4646493137886635273 | 2026-09-10 00:58:22 |

`Bandits2` and `BanditsWeekOne` do not declare a `modversion` in `mod.info`; Workshop manifest/update metadata is recorded instead.

Not found anywhere in installed Workshop `mod.info`/`workshop.txt`, and not active: `CWBanditsPerfTest`, Project Remnants, a Week One/Project Remnants patch, and PZ NPC Spawning System.

## Configuration evolution

| Snapshot time (ET) | Mods | Workshop | Relevant order |
|---|---:|---:|---|
| 00:37:44 | 241 | 210 | `Bandits2;CWModpackCompatibility` |
| 01:22:16 | 241 | 210 | `Bandits2;CWModpackCompatibility` |
| 01:47:34 | 242 | 211 | `Bandits2;CWModpackCompatibility;BanditsWeekOne` |
| 01:49:47 | 242 | 211 | same |
| 02:01:12 | 243 | 212 | plus `BanditsWeekOneCommandWheel` |
| 02:09:34 | 244 | 213 | same relevant order |
| 02:18:25 | 245 | 214 | same relevant order |
| 02:22:28 | 246 | 215 | same relevant order |
| 02:36:53 active | 247 | 219 | same relevant order |

Snapshots are in `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\profile-state\config-backups`.

## SHA-256

| SHA-256 | Evidence path |
|---|---|
| `E88FE70F7C3B969E078343D9BC9E8586F5AD732DB8A46A812360B37750109DF4` | active `CWDayOneMP.ini` |
| `CD3B743998483B0A0B4AA04DDC1787177CD7989036109EBA4DC5682A9159A35D` | `profiles/CWDayOneMP/server-console.txt` |
| `A76C9D0B57EE538AA438AEEA51F5E4DB7089336101D3A8CEB7E29E1C2A560BC5` | 01:22 DebugLog (two-player, Week One absent) |
| `6657BB721A4F6A31340666CC00BA2C03BAC3FFBB21AC3020B2E5A0F31E3E5D48` | 02:36 DebugLog (Week One present, one client) |
| `A27C64AFE563AEC8BAF7FDCFFB2E975184360EDD7AAFCA45687C29411B82D778` | `Saves/Multiplayer/CWDayOneMP/global_mod_data.bin` at 02:43:32 |
| `656EFECDCE84674F2B2DD47140FEC036C6472A238724C5695C87B08C19ADDF33` | Week One `BWOPopControl.lua` |
| `6C732BBEADCB8DBF06457D1F497BCAC73DF441508305B6A663CE289D73DD656B` | Bandits `BanditServerSpawner.lua` |
| `7D27DB9D8FE9850BC251CE638DFCF7EB8002C857343B0972A5B706315532636D` | Bandits `BanditUtils.lua` |

## Repository state

- Investigation repository: `C:\GameServers\CW-Modpack-Compatibility`
- Remote: `https://github.com/Bokicks-Labs/CW-Modpack-Compatibility.git`
- Investigation started at local `3c88468`; fast-forwarded without conflict to upstream `0dbc0ba` before adding these documents.
- The server's installed compatibility Workshop artifact is version 1.1.5 and therefore not identical to repository head 1.1.6. The intervening repository change concerns the Oshkosh/DAMN helper and is unrelated to NPC lifecycle.

## Save observation

The preserved `global_mod_data.bin` contains printable keys for `BanditC0` through `BanditC31`, `Bandit`, `BanditPlayers`, and `BanditWeekOne`. Printable-string inspection alone is not a reliable serialized-table parser, so no claim is made about exact NPC counts or brain contents.
