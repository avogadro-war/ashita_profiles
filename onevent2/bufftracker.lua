local event = require('event')
local packet_dedupe = require('packet_dedupe')
local struct = require('struct')
local bufftracker = {}

bufftracker.buffGain = event:new()
bufftracker.buffLoss = event:new()
bufftracker.buffs = T{}
bufftracker.get_debug = nil -- to be set by main

local memMgr = AshitaCore and AshitaCore:GetMemoryManager()
local partyMgr = memMgr and memMgr:GetParty()
local ignoreNext = false
--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function log(msg)
    if bufftracker.get_debug and bufftracker.get_debug() then
        print(('[bufftracker] %s'):fmt(msg))
    end
end
local function should_process_packet(e)
    packet_dedupe.record_packets(e)
    return not packet_dedupe.check_duplicates(e)
end
-- debug 0x29 messages
local function hex_dump(str)
    return (str:gsub('.', function(c)
        return ('%02X '):format(c:byte())
    end))
end
-- Track buff loss (0x29)
ashita.events.register('packet_in', 'buff_loss_cb', function(e)
    if e.id ~= 0x29 then return end
    if packet_dedupe.check_duplicates(e) then return end

    log('[bufftracker][debug] 0x29 raw: ' .. hex_dump(e.data))

    local message_id = struct.unpack('H', e.data, 0x18 + 1) or 0
    if message_id ~= 206 then return end -- buff wears off

    local buff_id = struct.unpack('I', e.data, 0x0C + 1)
    local actor_id = struct.unpack('I', e.data, 0x08 + 1)
    if buff_id then
        bufftracker.buffLoss:trigger(buff_id, actor_id)
        log(('Lost buff %d by actor %d'):fmt(buff_id, actor_id))
    end
end)

ashita.events.register('packet_in', 'zoneChange_packet_in', function(e)
    if e.id == 0x00A then
        log('Zone change detected, will ignore next 0x063 buff sync')
        ignoreNext = true
    end
end)

bufftracker.last_buffs = bufftracker.last_buffs or T{}
-- We only trigger gains; losses are handled by 0x29.
ashita.events.register('packet_in', 'buff_resync_cb', function(e)
    if e.id ~= 0x063 then return end
    if packet_dedupe.check_duplicates(e) then return end

    local type = ashita.bits.unpack_be(e.data_raw, 32, 8)
    if type ~= 0x09 then return end

    -- Ignore first buff sync after zoning
    if ignoreNext then
        log('Ignoring first 0x063 buff sync after zone')
        ignoreNext = false
        return
    end

    local new_buffs = T{}
    for i = 1, 32 do
        local buff = struct.unpack('<H', e.data, 0x07 + 2 * i)
        if buff ~= 0 and buff ~= 255 then
            new_buffs[buff] = (new_buffs[buff] or 0) + 1
        end
    end

    -- Only check for gains compared to last buffs
    for buff_id, count in pairs(new_buffs) do
        local old_count = bufftracker.last_buffs[buff_id] or 0
        if count > old_count then
            for _ = 1, count - old_count do
                bufftracker.buffGain:trigger(buff_id)
                log(('Gained buff %d'):fmt(buff_id))
            end
        end
    end

    bufftracker.last_buffs = new_buffs
    log('Resynced buffs after zoning')
end)

return bufftracker