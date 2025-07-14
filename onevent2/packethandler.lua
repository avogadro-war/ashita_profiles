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
    ignoreNext = false,
    last_zoneid = nil,
}

local function debug_log(msg)
    if packethandler.get_debug then
        print(chat.header(addon.name):append(chat.message(msg)))
    end
end

function packethandler.start()

    ashita.events.register('packet_in', 'packet_in_handlers', function(e)
        packet_dedupe.record_packets(e);

        if e.id == 0x00A then
            local zoneId = struct.unpack('H', e.data, 0x10+1)
            if zoneId and zoneId ~= packethandler.last_zoneid then
                packethandler.last_zoneid = zoneId
                packethandler.onZoneChange:trigger(zoneId)
            end

        elseif e.id == 0x29 then
            if packet_dedupe.check_duplicates(e) then return end

            local message_id = struct.unpack('H', e.data, 0x18+1)
            if message_id == 206 then
                local buff_id = struct.unpack('I', e.data, 0x0C+1)
                local actor_id = struct.unpack('I', e.data, 0x08+1)
                if buff_id then
                    packethandler.buffLoss:trigger(buff_id, actor_id)
                end
            end

        elseif e.id == 0x063 then
            if packet_dedupe.check_duplicates(e) then return end
            if packethandler.ignoreNext then packethandler.ignoreNext = false return end

            local new_buffs = T{}
            for i = 1, 32 do
                local buff = struct.unpack('<H', e.data, 0x07 + 2 * i)
                if buff ~= 0 and buff ~= 255 then
                    new_buffs[buff] = (new_buffs[buff] or 0) + 1
                end
            end

            -- Only check for gains compared to last buffs
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
            debug_log('Resynced buffs after zoning')
        end
    end)
end

return packethandler