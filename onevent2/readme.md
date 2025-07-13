# 📦 onevent2 – Ashita4 Addon

Reacts to chat, buffs, zone changes, and bosses by running commands and playing sounds.  
Supports auto-loading triggers by job, boss, and zone.

---

## 📂 Directory Structure

onevent2/
├── addon.xml
├── onevent2.lua ← Main addon
├── packet_dedupe.lua ← Deduplication helper
├── bufftracker.lua ← Buff gain/loss detection
├── config/
│ └── known.lua ← Tables of known bosses, jobs, zones
├── triggers/
│ ├── jobs/
│ │ ├── sam_triggers.lua
│ │ └── rdm_triggers.lua
│ ├── bosses/
│ │ └── ody_boss1.lua
│ └── zones/
│ └── walk_of_echoes.lua
└── sounds/
├── gravity_lost.wav
└── buff_gain.wav


---

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

Commands:
Command	Description
/onevent debug	Toggle debug logging
/onevent pause	Temporarily stop reacting
/onevent unpause	Resume reacting
/onevent auto on/off	Enable or disable auto-loading of triggers
`/onevent add <trigger>	<action>`
/onevent remove <trigger>	Remove a boss trigger
/onevent removeall	Remove all triggers
/onevent removebossall	Remove boss triggers
/onevent removejoball	Remove job triggers
/onevent removezoneall	Remove zone triggers
/onevent list	List currently loaded triggers
/onevent loadjob <setname>	Load job triggers manually
/onevent mergejob <setname>	Merge additional job triggers
/onevent loadboss <setname>	Load boss triggers manually
/onevent loadzone <setname>	Load zone triggers manually

You can also use /oe instead of /onevent (e.g., /oe debug).
🎵 Trigger files

Trigger files are Lua files that return a table.
Jobs

Path: triggers/jobs/<job>_triggers.lua

Example (sam_triggers.lua):

return {
    chat_triggers = {
        { 'Light Skillchain', '/p → LIGHT skillchain!;sound:light.wav' },
        { 'Darkness Skillchain', '/p → DARKNESS!;sound:darkness.wav' },
    },
    buffgain_alerts = {
        [272] = 'buff_gain.wav'  -- Example buff ID → sound file
    },
    bufflose_alerts = {
        [11] = {
            self = 'gravity_lost.wav',
            other = 'gravity_on_target.wav'
        }
    }
}

Bosses

Path: triggers/bosses/<boss>.lua

Example:

return {
    { 'The boss is readying.*Ultimate Ability', '/p Ultimate incoming!;sound:alert.wav' },
    { 'The boss gains Enrage', '/p Enrage! Kite!;sound:enrage.wav' },
}

Zones

Path: triggers/zones/<zone>.lua

Example:

return {
    { 'An unstable rift appears', '/p Rift spawned!;sound:rift.wav' },
}

✏ How to add triggers

    Boss / zone names must be in config/known.lua
    Add entries like:

known.bosses = {
    ['odin'] = 'odin.lua',
    ['dynamis lord'] = 'dynamis_lord.lua',
}

known.zones = {
    [295] = 'walk_of_echoes' -- zoneId → filename (without .lua)
}

    Trigger files must return a table in the correct format (see examples above).

    Sound files should be in the /sounds folder, named to match what you reference.

🐛 Debugging tips

    Use /onevent debug to toggle detailed logs.

    Check Ashita console if a sound or command fails.

    Verify your trigger file returns a valid table; syntax errors will prevent loading.

📜 License / Credits

    Original by atom0s

    Buff tracking, audio alert functionality, dedupe extensions by Avogadro

    Buff events / zone change pattern inspired by Will

❤️ Contribute

Have ideas or triggers? Feel free to submit a pull request or share your custom triggers!

