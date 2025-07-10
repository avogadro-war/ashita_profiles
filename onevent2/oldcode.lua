--[[ashita.events.register('packet_in', 'bufflose_cb', function (e)
    if onevent.paused then return end
    if e.id ~= 0x29 then return end

    local message_id = struct.unpack('H', e.data, 0x18 + 1)
    if message_id ~= 206 then return end -- buff wears off

    local buff_id = struct.unpack('I', e.data, 0x0C + 1)
    local actor_id = struct.unpack('I', e.data, 0x08 + 1)
    local my_id = partyMgr and partyMgr:GetMemberServerId(0)
    if not my_id or not buff_id then return end

    local alert = onevent.bufflose_alerts and onevent.bufflose_alerts[buff_id]
    if not alert then return end

    local soundFile = nil
    if type(alert) == 'string' then
        -- Simple case: just care about self
        if actor_id == my_id then
            soundFile = alert
        end
    elseif type(alert) == 'table' then
        if actor_id == my_id and alert.self then
            soundFile = alert.self
        elseif actor_id ~= my_id and alert.other then
            soundFile = alert.other
        end
    end

    if soundFile then
        local soundPath = string.format('%ssounds\\%s', addon.path, soundFile)
        if file_exists(soundPath) then
            ashita.misc.play_sound(soundPath)
            if onevent.debug then
                print(chat.header(addon.name):append(chat.message(
                    ('Buff %d wore off (%s): playing %s'):fmt(buff_id, actor_id == my_id and 'self' or 'other', soundFile)
                )))
            end
        elseif onevent.debug then
            print(chat.header(addon.name):append(chat.error('Missing sound file: ' .. soundFile)))
        end
    elseif onevent.debug then
        print(chat.header(addon.name):append(chat.message(
            ('Buff %d wore off (%s) but no sound configured.'):fmt(buff_id, actor_id == my_id and 'self' or 'other')
        )))
    end
end)]]
