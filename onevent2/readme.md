# 📦 onevent2 – Ashita4 Addon

Reacts to events defined by trigger files that evaluate and play audio alerts in response to:

- Chat events
- Status Gain and Status Loss (self and party)
- Events in zone
- Boss specific events  
    
Supports auto-loading triggers by job, boss, and zone.

---

## 📂 Directory Structure
```
onevent2/
├── onevent2.lua ← Main addon
├── utils/
│ ├── packethandler.lua
│ ├── autoload.lua
│ ├── statusIDs.lua
│ ├── event.lua
│ └── packetdedupe.lua
├── config/
│ └── known.lua ← Tables of known bosses, jobs, zones
├── triggers/
│ ├── jobs/
│ │ ├── sam_triggers.lua
│ │ ├── rdm_triggers.lua
│ │ └── ...
│ ├── bosses/
│ │ ├── ody_boss1.lua
│ │ └── ...
│ └── zones/
│ │ ├── walk_of_echoes.lua
│ │ └── ...
└── sounds/
    ├── stop.wav
    └── tf2.wav
    └── ...
```
## ⚙ How it works

Auto-loads triggers based on:

- Your main job  
- Your current zone  
- The current target (if it matches a known boss)

Reacts to:

- Chat messages  
- Buff gain / buff loss (with actor detection)

Executes:

- In-game commands (via `/command`)  
- Plays sound files (WAV)

Uses a deduplication system to avoid reacting multiple times to repeated packets.

---

## 🧩 Components

| File                  | Purpose                                                 |
|-----------------------|---------------------------------------------------------|
| `onevent2.lua`        | Main addon logic, command handler, trigger loading, event hooks |
| `bufftracker.lua`     | Tracks buff gains & losses (with zone sync and dedupe)  |
| `packet_dedupe.lua`   | Tracks recent packets to prevent double triggers        |
| `config/known.lua`    | Tables of known bosses, zones, jobs (by name or zoneId) |
| `triggers/`           | Contains your custom trigger sets (by job, boss, or zone) |
| `sounds/`             | Sound files to be played when triggers fire             |

---

## ▶️ Usage

**Load addon:**

```bash
/addon load onevent2
```
| Command                          | Description                         |
|---------------------------------|-----------------------------------|
| `/onevent debug`                 | Toggle debug logging               |
| `/onevent pause`                 | Temporarily stop reacting          |
| `/onevent unpause`               | Resume reacting                   |
| `/onevent auto on/off`           | Enable or disable auto-loading of triggers |
| `/onevent add <trigger> \| <action>` | Add a trigger                  |
| `/onevent remove <trigger>`      | Remove a trigger                  |
| `/onevent removeall`             | Remove all triggers               |
| `/onevent removebossall`         | Remove boss triggers              |
| `/onevent removejoball`          | Remove job triggers               |
| `/onevent removezoneall`         | Remove zone triggers              |
| `/onevent list`                  | List currently loaded triggers    |
| `/onevent loadjob <setname>`     | Load job triggers manually        |
| `/onevent mergejob <setname>`    | Merge additional job triggers     |
| `/onevent loadboss <setname>`    | Load boss triggers manually       |
| `/onevent loadzone <setname>`    | Load zone triggers manually       |

🎵 **Trigger files**

Trigger files are Lua files that return a table.
Status sensitive alerts can be evaluated either by text matching (statusIDs.lua to add custom shortening of desired names) or by ID (see statusIDs.lua).

**Jobs**

- Path: `triggers/jobs/<job>_triggers.lua`
- Example (rdm_triggers.lua):
```
return {
    chat_triggers = T{
        -- { 'readies Dark Thorn', '/echo Spikes!; sound:mgs.wav' },
        { 'Mortal Ray',    '/echo Turn!; sound:tf2.wav' },
        { 'longer weighed down', 'sound: stop.wav' },
    },
    bufflose_alerts = T{
        [432] = 'doorcat.wav',                                     -- Temper
        [419] = 'doorcat.wav',                                     -- Composure
        [48]  = 'wompwomp.wav',                                    -- Chainspell
        [43]  = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Refresh
        [33]  = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Haste
        [116] = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Phalanx
        -- other buff IDs...
    },
    buffgain_alerts = {
        [15]  = 'doom.wav',                                        -- Doom
        [6]   = 'debuff.wav',                                      -- Silence
        [4]   = 'debuff.wav',                                      -- Paralyze
        [16]  = 'debuff.wav',                                      -- Amnesia
        [177] = 'debuff.wav',                                      -- Encumbrance
        -- etc.
    },
    debuffexpire_alerts = {
        [12] = { other = 'agh.wav' },                             -- Gravity
    },
}
```

**Bosses**

- Path: triggers/bosses/<boss>.lua
- Example:
```
return {
    { 'The boss is readying.*Ultimate Ability', '/p Ultimate incoming!;sound:alert.wav' },
    { 'The boss gains Enrage', '/p Enrage! Kite!;sound:enrage.wav' },
}
```
**Zones**

- Path: triggers/zones/<zone>.lua
- Example:

```
return {
    { 'An unstable rift appears', '/p Rift spawned!;sound:rift.wav' },
}
```

✏ **How to add triggers**

- Boss / zone names must be in config/known.lua to auto-load
- Add entries like:
```
known.bosses = {
    ['odin'] = 'odin.lua',
    ['dynamis lord'] = 'dynamis_lord.lua',
}

known.zones = {
    [295] = 'walk_of_echoes' 
}
```
- Trigger files must return a table in the correct format (see examples above).
- Sound files should be in the /sounds folder, named to match what you reference.

🐛 **Debugging tips**

- Use `/onevent debug` to toggle detailed logs.
- Check Ashita console if a sound or command fails.
- Verify your trigger file returns a valid table; syntax errors will prevent loading.

📜 **License / Credits**

    Original by atom0s

    Buff tracking, audio alert functionality by Avogadro
    
    Dedupe inspired by Thorny/Simplelog
    
    Buff events / zone change pattern inspired by Will

❤️ Contribute

Have ideas or triggers? Feel free to submit a pull request or share your custom triggers!
