return {
    chat_triggers = T{
        -- { 'readies Dark Thorn', '/echo Spikes!; sound:mgs.wav' },
        -- { 'readies Fatal Allure', '/echo Charm!; sound:tf2.wav' },
    },
    bufflose_alerts = T{
        [432] = 'doorcat.wav',                                     -- Temper
        [419] = 'doorcat.wav',                                     -- Composure
        [48]  = 'wompwomp.wav',                                    -- Chainspell
        [43]  = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Refresh
        [33]  = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Haste
        [116] = { self = 'doorcat.wav', other = 'factorio.wav' },  -- Phalanx
        -- other buff IDs...
    }
}
