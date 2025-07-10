--[[
* Onevent Addon - Auto-load by job & boss, toggle, merge, remove
* Author: atom0s + extended by Avogadro
* Reacts to chat by running commands & sounds; auto-loads triggers by job/boss.
--]]

addon.name    = 'onevent2';
addon.author  = 'atom0s + Avogadro';
addon.version = '1.0';
addon.desc    = 'Reacts to chat with commands, sounds; auto-loads job/boss triggers.';

--------------------------------------------------------------------------------
-- Dependancies
--------------------------------------------------------------------------------
require('common');
local known = require('config/known')
local chat = require('chat');
--------------------------------------------------------------------------------
-- Managers
--------------------------------------------------------------------------------
local memMgr = AshitaCore and AshitaCore:GetMemoryManager()
local targetMgr = memMgr and memMgr:GetTarget()
local entityMgr = memMgr and memMgr:GetEntity()
local partyMgr  = memMgr and memMgr:GetParty()
local playerMgr = memMgr and memMgr:GetPlayer()
--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------
local onevent = {
    job_triggers       = T{},
    boss_triggers      = T{},
    zone_triggers      = T{},
    last_job           = nil,
    last_boss          = nil,
    last_zone          = nil,
    paused             = false,
    auto_load          = true,  -- starts enabled
    bufflose_alerts    = {},
    debug              = false,
    missing_target_mgr = false,
};
--------------------------------------------------------------------------------
-- Load from config
--------------------------------------------------------------------------------
local known_bosses = known.bosses
local known_zones = known.zones
local jobNames = known.jobs
--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
local function pause() onevent.paused = true; end
local function unpause() onevent.paused = false; end

local startswith = function(s, start) return s:sub(1, #start) == start end
local trim = function(s) return (s:gsub("^%s*(.-)%s*$", "%1")) end
local split = function(s, sep)
    local t={} for str in string.gmatch(s, "([^"..sep.."]+)") do table.insert(t, str) end
    return t
end

local function file_exists(path)
    local ok, f = pcall(io.open, path, "r")
    if ok and f then f:close(); return true end
    return false
end

local function process_triggers(triggers, e)
    triggers:ieach(function (v)
        if e.message_modified:contains(v[1]) then
            local actions = v[2]:split(';')
            for _, act in ipairs(actions) do
                act = act:trim()
                if startswith(act, 'sound:') then
                    local soundFile = act:sub(7):trim()
                    -- Build full path: addon.path points to your addon folder
                    local soundPath = string.format('%ssounds\\%s', addon.path, soundFile)
                    if onevent.debug then
                        print(chat.header(addon.name):append(chat.message('Playing sound: ' .. soundPath)))
                    end
                    if file_exists(soundPath) then
                        ashita.misc.play_sound(soundPath)
                    else
                        if onevent.debug then
                            print(chat.header(addon.name):append(chat.error('Missing sound file: ' .. soundFile)))
                        end
                    end
                else
                    -- Defensive: get chat manager safely
                    local chatManager = AshitaCore and AshitaCore:GetChatManager()
                    if chatManager then
                        chatManager:QueueCommand(1, act)
                    else
                        if onevent.debug then
                            print(chat.header(addon.name):append(chat.error('ChatManager unavailable; could not run command: ' .. act)))
                        end
                    end
                end
            end
        end
    end)
end
--------------------------------------------------------------------------------
-- Loaders
--------------------------------------------------------------------------------
local function load_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, jobfile = pcall(dofile, path)

    if ok and type(jobfile) == 'table' then
        if (jobfile.chat_triggers ~= nil and type(jobfile.chat_triggers) ~= 'table') or
           (jobfile.bufflose_alerts ~= nil and type(jobfile.bufflose_alerts) ~= 'table') then
            print(chat.header(addon.name):append(chat.error(
                ('Trigger file malformed: %s'):fmt(setname)
            )))
            return
        end

        local oldCount = #onevent.job_triggers
        onevent.job_triggers = T(jobfile.chat_triggers or {})
        onevent.bufflose_alerts = jobfile.bufflose_alerts or {}
        print(chat.header(addon.name):append(chat.message(
            ('Loaded job triggers: %s (replaced %d)'):fmt(chat.success(setname), oldCount)
        )))
    else
        print(chat.header(addon.name):append(chat.error(
            ('Failed to load job trigger set: %s'):fmt(chat.success(setname))
        )))
    end
end

local function merge_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, jobfile = pcall(dofile, path)

    if ok and type(jobfile) == 'table' then
        local oldCount = #onevent.job_triggers

        -- Merge chat triggers
        if jobfile.chat_triggers then
            jobfile.chat_triggers:ieach(function (v)
                onevent.job_triggers:insert(v)
            end)
        end
        -- Merge bufflose_alerts
        if jobfile.bufflose_alerts then
            for k, v in pairs(jobfile.bufflose_alerts) do
                onevent.bufflose_alerts[k] = v
            end
        end
        print(chat.header(addon.name):append(chat.message(
            ('Merged %d triggers; total now: %d'):fmt(#(jobfile.chat_triggers or {}), #onevent.job_triggers)
        )))
    else
        print(chat.header(addon.name):append(chat.error(
            ('Failed to merge job trigger set: %s'):fmt(chat.success(setname))
        )))
    end
end

local function load_boss_triggers(setname)
    local path = string.format('%striggers/bosses/%s.lua', addon.path, setname)
    local ok, triggers = pcall(dofile, path)
    if ok and type(triggers) == 'table' then
        local oldCount = #onevent.boss_triggers
        onevent.boss_triggers = T(triggers)
        print(chat.header(addon.name):append(chat.message(('Loaded boss triggers: %s (replaced %d)'):fmt(chat.success(setname), oldCount))))
    else
        print(chat.header(addon.name):append(chat.error(('Failed to load boss trigger set: %s'):fmt(chat.success(setname)))))
    end
end

local function load_zone_triggers(setname)
    local path = string.format('%striggers/zones/%s.lua', addon.path, setname)
    if onevent.debug then
        print(chat.header(addon.name):append(chat.message(('Loading zone triggers file: %s'):fmt(path))))
    end

    local ok, triggers = pcall(dofile, path)
    if ok and type(triggers) == 'table' then
        local oldCount = #onevent.zone_triggers
        onevent.zone_triggers = T(triggers)
        print(chat.header(addon.name):append(chat.message(('Loaded zone triggers: %s (replaced %d)'):fmt(chat.success(setname), oldCount))))
    else
        print(chat.header(addon.name):append(chat.error(('Failed to load zone trigger set: %s'):fmt(chat.success(setname)))))
    end
end
--------------------------------------------------------------------------------
-- Help
--------------------------------------------------------------------------------
local function print_help(isError)
    if isError then
        print(chat.header(addon.name):append(chat.error('Invalid syntax. Use /onevent help')))
    else
        print(chat.header(addon.name):append(chat.message('Available commands:')))
    end

    local cmds = T{
        { '/onevent add <trigger>|<action>', 'Add/update boss trigger.' },
        { '/onevent remove <trigger>', 'Remove a boss trigger.' },
        { '/onevent removeall', 'Remove all triggers.' },
        { '/onevent removejoball', 'Remove all job triggers.' },
        { '/onevent removebossall', 'Remove all boss triggers.' },
        { '/onevent removezoneall', 'Remove all zone triggers.' },
        { '/onevent list', 'List current job & boss triggers separately.' },
        { '/onevent loadjob <setname>', 'Load job triggers (replace).' },
        { '/onevent mergejob <setname>', 'Merge triggers into job triggers.' },
        { '/onevent loadboss <setname>', 'Load boss triggers (replace).' },
        { '/onevent loadzone <setname>', 'Load zone triggers (replace).' },
        { '/onevent auto on|off', 'Enable/disable auto-load feature.' },
        { '/onevent help', 'Show help.' },
        { '/onevent debug', 'Toggle debug mode.' }, 
        { '/onevent pause', 'Temporarily disables all reactions.' },
        { '/onevent unpause', 'Resumes processing.' },
    }

    cmds:ieach(function (v)
        print(chat.header(addon.name):append(chat.error('Usage: ')):append(chat.message(v[1]):append(' - ')):append(chat.color1(6, v[2])))
    end)
end
--------------------------------------------------------------------------------
-- Parse /onevent add
--------------------------------------------------------------------------------
local function split_cmd(cmd)
    local cleaned = cmd:sub(cmd:find('/onevent add') and 14 or 9)
    local t, a = cleaned:match('([^,]+)%s*|%s*(.+)')
    return t and t:trim(), a and a:trim()
end
--------------------------------------------------------------------------------
-- Command handler
--------------------------------------------------------------------------------
local function cmd(e, args)
    local sub = args[2]:lower()

    if sub == 'add' and #args >= 3 then
        local trigger, action = split_cmd(e.command)
        if not action then
            print(chat.header(addon.name):append(chat.error('Usage: /onevent add <trigger>|<action>')))
            return
        end
        for _, v in ipairs(onevent.boss_triggers) do
            if v[1] == trigger then
                v[2] = action
                print(chat.header(addon.name):append(chat.message(('Updated boss trigger: %s => %s'):fmt(chat.success(trigger), chat.success(action)))))
                return
            end
        end
        table.insert(onevent.boss_triggers, { trigger, action })
        print(chat.header(addon.name):append(chat.message(('Added boss trigger: %s => %s'):fmt(chat.success(trigger), chat.success(action)))))
        return
    end

    if sub == 'remove' and #args >= 3 then
        local trigger = e.command:sub(e.command:find(' ', e.command:find(' ') + 1) + 1):trim()
        for i, v in ipairs(onevent.boss_triggers) do
            if v[1] == trigger then
                table.remove(onevent.boss_triggers, i)
                print(chat.header(addon.name):append(chat.message(('Removed boss trigger: %s'):fmt(chat.success(trigger)))))
                return
            end
        end
        print(chat.header(addon.name):append(chat.error(('No boss trigger found to remove: %s'):fmt(chat.success(trigger)))))
        return
    end

    if sub == 'removeall' or sub == 'removebossall' then
        local old = #onevent.boss_triggers
        onevent.boss_triggers = T{}
        print(chat.header(addon.name):append(chat.message(('Removed %d boss triggers.'):fmt(old))))
        return
    end

    if sub == 'removeall' or sub == 'removejoball' then
        local old = #onevent.job_triggers
        onevent.job_triggers = T{}
        print(chat.header(addon.name):append(chat.message(('Removed %d job triggers.'):fmt(old))))
        return
    end

    if sub == 'removeall' or sub == 'removezoneall' then
        local old = #onevent.zone_triggers
        onevent.zone_triggers = T{}
        print(chat.header(addon.name):append(chat.message(('Removed %d zone triggers.'):fmt(old))))
        return
    end

    if sub == 'list' then
        print(chat.header(addon.name):append(chat.message('--- Job Triggers ---')))
        if not next(onevent.job_triggers) then print(chat.message('None')) else
            for _, v in ipairs(onevent.job_triggers) do
                print(chat.message(('Trigger: %s => %s'):fmt(v[1], v[2])))
            end
        end
        print(chat.header(addon.name):append(chat.message('--- Boss Triggers ---')))
        if #onevent.boss_triggers == 0 then print(chat.message('None')) else
            for _, v in ipairs(onevent.boss_triggers) do
                print(chat.message(('Trigger: %s => %s'):fmt(v[1], v[2])))
            end
        end
           print(chat.header(addon.name):append(chat.message('--- Zone Triggers ---')))
        if #onevent.zone_triggers == 0 then print(chat.message('None')) else
            for _, v in ipairs(onevent.zone_triggers) do
                print(chat.message(('Trigger: %s => %s'):fmt(v[1], v[2])))
            end
        end
        return
    end

    if sub == 'loadjob' and #args >= 3 then load_job_triggers(args[3]); return end
    if sub == 'mergejob' and #args >= 3 then merge_job_triggers(args[3]); return end
    if sub == 'loadboss' and #args >= 3 then load_boss_triggers(args[3]); return end
    if sub == 'loadzone' and #args >= 3 then load_zone_triggers(args[3]) return end
    if sub == 'auto' and #args >= 3 then
        if args[3]:lower() == 'on' then
            onevent.auto_load = true
            print(chat.header(addon.name):append(chat.message('Auto-load enabled.')))
        elseif args[3]:lower() == 'off' then
            onevent.auto_load = false
            print(chat.header(addon.name):append(chat.message('Auto-load disabled.')))
        else
            print(chat.header(addon.name):append(chat.error('Usage: /onevent auto on|off')))
        end
        return
    end
    if sub == 'help' then print_help(false); return end
    if sub == 'debug' then 
        onevent.debug = not onevent.debug 
        print(chat.header(addon.name):append(chat.message(('Debug mode %s'):fmt(onevent.debug and 'enabled' or 'disabled'))))
        return 
    end
    if sub == 'pause' then pause(); print(chat.header(addon.name):append(chat.message('Paused.'))); return end
    if sub == 'unpause' then unpause(); print(chat.header(addon.name):append(chat.message('Unpaused.'))); return end

    print_help(true)

end
--------------------------------------------------------------------------------
-- Command event
--------------------------------------------------------------------------------
ashita.events.register('command', 'command_cb', function (e)
    local args = e.command:args()
    if #args >= 1 and not (args[1]:ieq('/onevent') or args[1]:ieq('/oe')) then return end
    e.blocked = true
    if #args <= 1 then return end
    (function() end):dispatch(pause, cmd, unpause)(e, args)
end)
--------------------------------------------------------------------------------
-- Text in event
--------------------------------------------------------------------------------
ashita.events.register('text_in', 'text_in_cb', function (e)
    if onevent.paused then return end
    process_triggers(onevent.job_triggers, e)
    process_triggers(onevent.boss_triggers, e)
    process_triggers(onevent.zone_triggers, e)
end)
--------------------------------------------------------------------------------
-- Auto-load by job, target, zone
--------------------------------------------------------------------------------
local last_check = os.clock()
ashita.events.register('d3d_present', 'auto_load_check', function ()
    local function debug_log_loaded(type, name)
        print(chat.header(addon.name):append(chat.message(('Auto-loaded %s triggers: %s'):fmt(type, name))))
    end

    if not onevent.auto_load then return end
    if os.clock() - last_check < 2 then return end
    last_check = os.clock()

    -- Auto-load by job
    local player = playerMgr
    local jobId = player and player:GetMainJob()
    local job = jobId and jobNames[jobId]
    if onevent.debug and not jobId then
        print(chat.header(addon.name):append(chat.error('Player jobId not ready')))
    elseif job and job ~= onevent.last_job then
        local filename = string.format('%s_triggers', job:lower())
        debug_log_loaded('job', job)
        load_job_triggers(filename)
        onevent.last_job = job
    end

    -- Auto-load by boss target
    if not memMgr then return end

    if not targetMgr or not entityMgr then
        if onevent.debug and not onevent.missing_target_mgr then
            onevent.missing_target_mgr = true
        end
        return
    end
    onevent.missing_target_mgr = false

    local targetIndex = targetMgr:GetTargetIndex(0)
    if targetIndex and targetIndex > 0 then
        local targetName = entityMgr:GetName(targetIndex)
        if targetName and type(targetName) == 'string' and targetName ~= '' then
            local targetLower = targetName:lower()
            if targetLower ~= onevent.last_boss then
                local trigger_file = known_bosses[targetLower]
                if trigger_file then
                    load_boss_triggers(trigger_file)
                    debug_log_loaded('boss', targetName)
                    onevent.last_boss = targetLower
                end
            end
        end
    end
    -- Auto load by zone
    local zoneId = partyMgr and partyMgr:GetMemberZone(0)
    if zoneId then
        local zoneName = known_zones[zoneId]
        if zoneName then
            local filename = zoneName:lower():gsub(' ', '_')
            if filename ~= onevent.last_zone then
                load_zone_triggers(filename)
                debug_log_loaded('zone', zoneName)
                onevent.last_zone = filename
            end
        else
            if #onevent.zone_triggers > 0 then
                print(chat.header(addon.name):append(chat.message(('Unknown zoneId %d; clearing zone triggers.'):fmt(zoneId))))
                onevent.zone_triggers = T{}
                onevent.last_zone = nil
            end
        end
    else
        if onevent.debug then
            print(chat.header(addon.name):append(chat.error('Party manager missing or zoneId nil')))
        end
    end
end)

ashita.events.register('packet_in', 'bufflose_cb', function (e)
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
end)