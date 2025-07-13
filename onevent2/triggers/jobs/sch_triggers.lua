return {
    chat_triggers = T{
        --{ 'readies Dark Thorn', '/echo Spikes!; sound:mgs.wav' },
        --{ 'readies Fatal Allure', '/echo Charm!; sound:tf2.wav' },
    },
    bufflose_alerts = T{
        [407] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Klimaform
        [178] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Firestorm I
        [589] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Firestorm II
        [183] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Rainstorm I
        [594] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Rainstorm II
        [182] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Thunderstorm I
        [593] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Thunderstorm II
        [181] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Sandstorm I
        [592] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Sandstorm II
        [180] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Windstorm I
        [591] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Windstorm II
        [179] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Hailstorm I
        [590] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Hailstorm II
        [184] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Aurorastorm I
        [595] = { self = 'amogus.wav', other = 'factorio.wav' },  -- AUrorastorm II
        [185] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Voidstorm I
        [596] = { self = 'amogus.wav', other = 'factorio.wav' },  -- Voidstorm II
        -- other buff IDs
    },
    buffgain_alerts = {
        [15]  = 'doom.wav',                                        -- Doom
        [6]   = 'debuff.wav',                                      -- Silence
        [4]   = 'debuff.wav',                                      -- Paralyze
        [16]  = 'debuff.wav',                                      -- Amnesia
        [177] = 'debuff.wav',                                      -- Encumbrance
        -- etc.
    },
}