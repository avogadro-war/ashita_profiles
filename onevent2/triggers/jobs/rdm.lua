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
