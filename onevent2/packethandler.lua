local event         = require('event')
local packet_dedupe = require('packet_dedupe')
local struct        = require('struct')
local chat          = require('chat')

local packethandler = {
    buffGain = event:new(),
    buffLoss = event:new(),
    onZoneChange = event:new(),
    get_debug = nil,
    last_buffs = T{},
    last_zoneid = nil,
    ignoreNextBuffSync = false,  -- skip first buff sync after zoning
}

local function debug_log(msg)
    if packethandler.get_debug and packethandler.get_debug() then
        print(chat.header(addon.name):append(chat.message(msg)))
    end
end

function packethandler.start()
    ashita.events.register('packet_in', 'packet_in_handlers', function(e)
        packet_dedupe.record_packets(e)

        if e.id == 0x00A then
            local zoneId = struct.unpack('H', e.data, 0x10+1)
            if zoneId and zoneId ~= packethandler.last_zoneid then
                packethandler.last_zoneid = zoneId
                packethandler.ignoreNextBuffSync = true
                packethandler.onZoneChange:trigger(zoneId)
                debug_log(('Detected zone change to %d; will skip next buff sync diff'):format(zoneId))
            end

        elseif e.id == 0x29 then
            if packet_dedupe.check_duplicates(e) then return end
            local message_id = struct.unpack('H', e.data, 0x18+1)
            if message_id == 206 then
                local buff_id = struct.unpack('I', e.data, 0x0C+1)
                local actor_id = struct.unpack('I', e.data, 0x08+1)
                if buff_id then
                    packethandler.buffLoss:trigger(buff_id, actor_id)
                    debug_log(('Buff %d lost by actor %d'):format(buff_id, actor_id))
                end
            end

        elseif e.id == 0x063 then
            if packet_dedupe.check_duplicates(e) then return end

            -- Check type field
            local type = ashita.bits.unpack_be(e.data_raw, 32, 8)
            if type ~= 0x09 then return end

            local new_buffs = T{}
            for i = 1, 32 do
                local buff = struct.unpack('<H', e.data, 0x07 + 2 * i)
                if buff ~= 0 and buff ~= 255 then
                    new_buffs[buff] = (new_buffs[buff] or 0) + 1
                end
            end

            if packethandler.ignoreNextBuffSync then
                -- skip first buff sync after zone
                packethandler.last_buffs = new_buffs
                packethandler.ignoreNextBuffSync = false
                debug_log('Initial buff sync after zoning; skipped gain detection')
            else
                -- detect gains normally
                for buff_id, count in pairs(new_buffs) do
                    local old_count = packethandler.last_buffs[buff_id] or 0
                    if count > old_count then
                        for _ = 1, count - old_count do
                            packethandler.buffGain:trigger(buff_id)
                            debug_log(('Gained buff %d'):format(buff_id))
                        end
                    end
                end
                packethandler.last_buffs = new_buffs
                debug_log('Resynced buffs after buff packet')
            end
        end
    end)
end

return packethandler