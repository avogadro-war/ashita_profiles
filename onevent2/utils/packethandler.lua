local event         = require('utils.event')
local packet_dedupe = require('utils.packet_dedupe')
local struct        = require('struct')
local chat          = require('chat')

local packethandler = {
    buffGain = event:new(),
    buffLoss = event:new(),
    debuffExpire = event:new(),
    onZoneChange = event:new(),
    get_debug = nil,
    last_buffs = T{},
    last_zoneid = nil,
    current_buffs = T{},         -- Tracks current buffs on player
    buff_sync_handled_time = 0,  -- Timestamp of last processed buff sync
}

local function debug_log(msg)
    if packethandler.get_debug and packethandler.get_debug() then
        print(chat.header('packethandler'):append(chat.message(msg)))
    end
end

local os_time = os.time
local cooldown_after_zone = 1 -- seconds

function packethandler.start()
    ashita.events.register('packet_in', 'packet_in_handlers', function(e)
        packet_dedupe.record_packets(e)

        if e.id == 0x00A then
            -- Zone change
            local zoneId = struct.unpack('H', e.data, 0x10 + 1)
            if zoneId and zoneId ~= packethandler.last_zoneid then
                packethandler.last_zoneid = zoneId

                -- Save last buffs as old buffs for diffing
                packethandler.old_buffs = T{}
                for k, v in pairs(packethandler.current_buffs or {}) do
                    packethandler.old_buffs[k] = v
                end

                -- Clear current buffs until buff sync packet updates it
                packethandler.current_buffs = T{}

                packethandler.buff_sync_handled_time = 0
                debug_log(('Detected zone change to %d; stored old buffs and cleared current buffs'):format(zoneId))
                packethandler.onZoneChange:trigger(zoneId)
            end

        elseif e.id == 0x29 then
            -- Debuff messages
            if packet_dedupe.check_duplicates(e) then return end

            local message_id = struct.unpack('H', e.data, 0x18 + 1)
            local actor_id   = struct.unpack('I', e.data, 0x08 + 1)
            local buff_id    = struct.unpack('I', e.data, 0x0C + 1)

            local expire_messages = T{ 64, 206, 204, 350, 351, 205, 321, 322 }

            if message_id == 206 then
                if buff_id then
                    packethandler.buffLoss:trigger(buff_id, actor_id)
                    debug_log(('Buff %d lost by actor %d'):format(buff_id, actor_id))
                end
            elseif expire_messages:contains(message_id) then
                if buff_id then
                    packethandler.debuffExpire:trigger(buff_id, actor_id, message_id)
                    debug_log(('Debuff %d expired on actor %d; message_id %d'):format(buff_id, actor_id, message_id))
                end
            end

        elseif e.id == 0x063 then
            -- Buff sync
            if packet_dedupe.check_duplicates(e) then return end

            local now = os_time()
            if packethandler.buff_sync_handled_time ~= nil and (now - packethandler.buff_sync_handled_time) < cooldown_after_zone then
                debug_log('Ignoring buff sync due to cooldown after zone')
                return
            end

            local type = ashita.bits.unpack_be(e.data_raw, 32, 8)
            if type ~= 0x09 then return end

            local new_buffs = T{}
            for i = 1, 32 do
                local buff = struct.unpack('<H', e.data, 0x07 + 2 * i)
                if buff ~= 0 and buff ~= 255 then
                    new_buffs[buff] = true
                end
            end

            if packethandler.old_buffs then
                -- Compare new buffs to old buffs and trigger buffGain for new ones
                for buff_id, _ in pairs(new_buffs) do
                    local was_present = packethandler.old_buffs[buff_id]
                    if not was_present then
                        packethandler.buffGain:trigger(buff_id)
                        debug_log(('Gained buff %d (post-zone baseline)'):format(buff_id))
                    else
                        debug_log(('Suppressed buff %d (already present before zoning)'):format(buff_id))
                    end
                end

                -- Update current buffs
                packethandler.current_buffs = new_buffs
                packethandler.old_buffs = nil
                packethandler.buff_sync_handled_time = now
                debug_log('Processed first buff sync using old buffs after zoning')
                return
            end

            if not packethandler.old_buffs then
                -- Compare new buffs to last buffs and trigger buffGain for new ones
                for buff_id, _ in pairs(new_buffs) do
                    local was_present = packethandler.current_buffs[buff_id]
                    if not was_present then
                        packethandler.buffGain:trigger(buff_id)
                        debug_log(('Gained buff %d'):format(buff_id))
                    else
                        debug_log(('Suppressed buff %d (already present in last)'):format(buff_id))
                    end
                end

                -- Update current buffs
                packethandler.current_buffs = new_buffs
                debug_log('Resynced buffs after buff packet')
            end
        end
    end)

    -- Update buffGain handler to track current_buffs and trigger only on real gains
    packethandler.buffGain:register(function(buff_id)
        if not packethandler.current_buffs[buff_id] then
            packethandler.current_buffs[buff_id] = true
            -- Forward the event for alert handling outside
            -- e.g. main addon listens for packethandler.buffGain and plays sounds
        else
            debug_log(('Buff gain %d suppressed: already active'):format(buff_id))
        end
    end)

    -- Update buffLoss handler to track current_buffs and trigger only on real losses
    packethandler.buffLoss:register(function(buff_id, actor_id)
        if packethandler.current_buffs[buff_id] then
            packethandler.current_buffs[buff_id] = nil
            -- Forward the event for alert handling outside
        else
            debug_log(('Buff loss %d suppressed: not tracked as active'):format(buff_id))
        end
    end)
end

return packethandler