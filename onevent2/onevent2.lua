--[[
* Onevent2 Addon - Auto-load by job, boss, zone; reacts to chat & buffs with commands & sounds.
* Author: atom0s + extended by Avogadro + library code by Will
--]]

addon.name    = 'onevent2';
addon.author  = 'original: atom0s | extended: Avogadro | events/buffChange/zoneChange code: Will';
addon.version = '1.0';
addon.desc    = 'Reacts to chat, buffs, auto-loads triggers by job/boss/zone.';
--------------------------------------------------------------------------------
-- Dependencies
--------------------------------------------------------------------------------
require('common')
local known         = require('config/known')
local chat          = require('chat')
local autoload      = require('autoload')
local packethandler = require('packethandler')
local packet_dedupe = require('packet_dedupe')
--------------------------------------------------------------------------------
-- Managers
--------------------------------------------------------------------------------
local memMgr    = AshitaCore and AshitaCore:GetMemoryManager()
local targetMgr = memMgr and memMgr:GetTarget()
local entityMgr = memMgr and memMgr:GetEntity()
local partyMgr  = memMgr and memMgr:GetParty()
local playerMgr = memMgr and memMgr:GetPlayer()
local chatManager = AshitaCore and AshitaCore:GetChatManager()
--------------------------------------------------------------------------------
-- State
--------------------------------------------------------------------------------
local onevent = {
    job_triggers       = T{},
    boss_triggers      = T{},
    zone_triggers      = T{},
    bufflose_alerts    = {},
    buffgain_alerts    = {},
    paused             = false,
    debug              = false,
}

--------------------------------------------------------------------------------
-- Config
--------------------------------------------------------------------------------
local known_bosses = known.bosses
local known_zones  = known.zones
local jobNames     = known.jobs
local sounds_path  = addon.path .. 'sounds\\'
--------------------------------------------------------------------------------
-- Helpers
--------------------------------------------------------------------------------
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
local function is_party_or_player(actor_id)
    if not partyMgr then return false end
    for i = 0, 5 do
        local member_id = partyMgr:GetMemberServerId(i)
        if member_id > 0 and member_id == actor_id then
            return true
        end
    end
    return false
end
--------------------------------------------------------------------------------
-- Debug Helpers
--------------------------------------------------------------------------------
packethandler.get_debug = function()
    return onevent.debug
end
local function debug_log(msg)
    if onevent.debug then
        print(chat.header(addon.name):append(chat.message(msg)))
    end
end
local function debug_log_loaded(type, name)
    debug_log(('Auto-loaded %s triggers: %s'):fmt(type, name))
end
--------------------------------------------------------------------------------
-- Process triggers
--------------------------------------------------------------------------------
local function process_triggers(triggers, e)
    for _, v in ipairs(triggers) do
        if string.find(e.message_modified, v[1], 1, true) then
            local actions = split(v[2], ';')
            for _, act in ipairs(actions) do
                act = act:trim()
                if act:lower():startswith('sound:') then
                    local soundPath = sounds_path .. act:sub(7):trim()
                    if file_exists(soundPath) then
                        ashita.misc.play_sound(soundPath)
                        debug_log('Playing sound: ' .. soundPath)
                    else
                        debug_log('Missing sound file: ' .. soundPath)
                    end
                else
                    if chatManager then chatManager:QueueCommand(1, act)
                    else debug_log('ChatManager unavailable; could not run: ' .. act)
                    end
                end
            end
        end
    end
end
--------------------------------------------------------------------------------
-- Buff gain/loss
--------------------------------------------------------------------------------
packethandler.buffGain:register(function(buff_id)
    local alert = onevent.buffgain_alerts[buff_id]
    if alert then
        local soundPath = sounds_path .. alert
        if file_exists(soundPath) then
            ashita.misc.play_sound(soundPath)
            debug_log(('Buff gained %d: playing %s'):fmt(buff_id, alert))
        else
            debug_log('Missing sound file: ' .. alert)
        end
    else
        debug_log(('Buff gained %d but no alert configured'):fmt(buff_id))
    end
end)

packethandler.buffLoss:register(function(buff_id, actor_id)
    if onevent.paused then return end

    local my_id = partyMgr and partyMgr:GetMemberServerId(0)
    if not my_id then
        debug_log('Player server ID not ready yet; skipping buffLoss')
        return
    end

    local is_self_or_party = is_party_or_player(actor_id)
    local who = is_self_or_party and 'self_or_party' or 'other'
    local alert = onevent.bufflose_alerts[buff_id]
    local soundFile = nil
    
    if type(alert) == 'string' then
        if is_self_or_party then soundFile = alert end
    elseif type(alert) == 'table' then
        if is_self_or_party and alert.self then
            soundFile = alert.self
        elseif not is_self_or_party and alert.other then
            soundFile = alert.other
        end
    end

    if soundFile then
        local soundPath = sounds_path .. soundFile
        if file_exists(soundPath) then
            ashita.misc.play_sound(soundPath)
            debug_log(('Buff %d wore off (%s): playing %s'):fmt(buff_id, who, soundFile))
        else
            debug_log('Missing sound file: ' .. soundFile)
        end
    else
        debug_log(('Buff %d wore off (%s) but no alert configured'):fmt(buff_id, who))
    end
end)

--------------------------------------------------------------------------------
-- Loaders with validation
--------------------------------------------------------------------------------
local function load_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, jobfile = pcall(dofile, path)
    
    if not ok then
        print(chat.error('Failed to load job trigger set: '..setname..' ('..tostring(jobfile)..')'))
    elseif type(jobfile) ~= 'table' then
        print(chat.error('Trigger file '..setname..' did not return a table.'))
    else
        if (jobfile.chat_triggers and type(jobfile.chat_triggers) ~= 'table') or
           (jobfile.bufflose_alerts and type(jobfile.bufflose_alerts) ~= 'table') or
           (jobfile.buffgain_alerts and type(jobfile.buffgain_alerts) ~= 'table') then
            print(chat.error('Malformed trigger file: ' .. setname))
            return
        end
        local old = #onevent.job_triggers
        onevent.job_triggers = T(jobfile.chat_triggers or {})
        onevent.bufflose_alerts = jobfile.bufflose_alerts or {}
        onevent.buffgain_alerts = jobfile.buffgain_alerts or {}
        print(chat.message(('Loaded job triggers: %s (replaced %d)'):fmt(setname, old)))
    end
end

local function merge_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, jobfile = pcall(dofile, path)
    if ok and type(jobfile) == 'table' then
        local added = 0
        if jobfile.chat_triggers then
            for _,v in ipairs(jobfile.chat_triggers) do onevent.job_triggers:insert(v); added=added+1 end
        end
        for k,v in pairs(jobfile.bufflose_alerts or {}) do onevent.bufflose_alerts[k]=v end
        for k,v in pairs(jobfile.buffgain_alerts or {}) do onevent.buffgain_alerts[k]=v end
        print(chat.message(('Merged %d job triggers; total now %d'):fmt(added, #onevent.job_triggers)))
    else
        print(chat.error('Failed to merge job trigger set: ' .. setname))
    end
end

local function load_boss_triggers(setname)
    local ok, triggers = pcall(dofile, string.format('%striggers/bosses/%s.lua', addon.path, setname))
    if ok and type(triggers) == 'table' then
        local old = #onevent.boss_triggers
        onevent.boss_triggers = T(triggers)
        print(chat.message(('Loaded boss triggers: %s (replaced %d)'):fmt(setname, old)))
    else
        print(chat.error('Failed to load boss trigger set: ' .. setname))
    end
end

local function load_zone_triggers(setname)
    local ok, triggers = pcall(dofile, string.format('%striggers/zones/%s.lua', addon.path, setname))
    if ok and type(triggers) == 'table' then
        local old = #onevent.zone_triggers
        onevent.zone_triggers = T(triggers)
        print(chat.message(('Loaded zone triggers: %s (replaced %d)'):fmt(setname, old)))
    else
        print(chat.error('Failed to load zone trigger set: ' .. setname))
    end
end
--------------------------------------------------------------------------------
-- Table-driven command handler
--------------------------------------------------------------------------------
local commands = {
    add = function(args, raw)
        local s = raw:sub(#args[1]+#args[2]+3)
        local parts = split(s, '|')
        if not parts or #parts < 2 then
            print(chat.error('Usage: /onevent add <trigger>|<action> (found: '..s..')'))
            return
        end
        local trigger = trim(parts[1])
        local action = trim(parts[2])
        for _,v in ipairs(onevent.boss_triggers) do
            if v[1]==trigger then
                v[2]=action
                print('Updated boss trigger: '..trigger)
                return
            end
        end
        table.insert(onevent.boss_triggers, {trigger, action})
        print('Added boss trigger: '..trigger)
    end,
    remove = function(args, raw)
        local t = raw:sub(#args[1]+#args[2]+3):trim()
        for i,v in ipairs(onevent.boss_triggers) do
            if v[1]==t then table.remove(onevent.boss_triggers,i); print('Removed boss trigger: '..t); return end
        end
        print('No boss trigger found: '..t)
    end,
    removeall = function()
        local b,j,z = #onevent.boss_triggers,#onevent.job_triggers,#onevent.zone_triggers
        onevent.boss_triggers,onevent.job_triggers,onevent.zone_triggers=T{},T{},T{}
        print(('Removed all triggers (boss:%d, job:%d, zone:%d)'):fmt(b,j,z))
    end,
    removebossall = function() local n=#onevent.boss_triggers; onevent.boss_triggers=T{}; print(('Removed %d boss triggers'):fmt(n)) end,
    removejoball = function() local n=#onevent.job_triggers; onevent.job_triggers=T{}; print(('Removed %d job triggers'):fmt(n)) end,
    removezoneall = function() local n=#onevent.zone_triggers; onevent.zone_triggers=T{}; print(('Removed %d zone triggers'):fmt(n)) end,
    list = function()
        print('--- Job Triggers ---'); for _,v in ipairs(onevent.job_triggers) do print(v[1]..' => '..v[2]) end
        print('--- Boss Triggers ---'); for _,v in ipairs(onevent.boss_triggers) do print(v[1]..' => '..v[2]) end
        print('--- Zone Triggers ---'); for _,v in ipairs(onevent.zone_triggers) do print(v[1]..' => '..v[2]) end
    end,
    loadjob = function(args) if args[3] then load_job_triggers(args[3]) end end,
    mergejob= function(args) if args[3] then merge_job_triggers(args[3]) end end,
    loadboss= function(args) if args[3] then load_boss_triggers(args[3]) end end,
    loadzone= function(args) if args[3] then load_zone_triggers(args[3]) end end,
    auto = function(args) if args[3]=='on' then autoload.auto_load=true print('Auto-load on')
        elseif args[3]=='off' then autoload.auto_load=false print('Auto-load off')
        else print('Usage: /onevent auto on|off') end end,
    debug = function() onevent.debug=not onevent.debug; print('Debug: '..tostring(onevent.debug)) end,
    pause = function() onevent.paused=true; print('Paused.') end,
    unpause = function() onevent.paused=false; print('Unpaused.') end,
    help = function() print('Use /onevent help: add, remove, removeall, list, loadjob, mergejob, loadboss, loadzone, auto, debug, pause, unpause') end,
}

ashita.events.register('command','onevent_cmd',function(e)
    local args=e.command:args()
    if #args>=2 and (args[1]:ieq('/onevent') or args[1]:ieq('/oe')) then
        e.blocked=true
        local cmd=args[2]:lower()
        if commands[cmd] then commands[cmd](args,e.command) else commands.help() end
    end
end)
--------------------------------------------------------------------------------
-- Text_in
--------------------------------------------------------------------------------
ashita.events.register('text_in','react',function(e)
    if not onevent.paused then
        process_triggers(onevent.job_triggers,e)
        process_triggers(onevent.boss_triggers,e)
        process_triggers(onevent.zone_triggers,e)
    end
end)
---------------------
-- Dupe Prevention --
---------------------
ashita.events.register('packet_in', 'record_chunk_packets', function(e)
    if e.id == 0x28 then
        packet_dedupe.record_packets(e)
    end
end)
--------------------------------------------------------------------------------
-- Packet Handling
--------------------------------------------------------------------------------
packethandler.start()
--------------------------------------------------------------------------------
-- Auto-Load
--------------------------------------------------------------------------------
autoload.set_zone_trigger_loader(load_zone_triggers)

ashita.events.register('d3d_present', 'auto', function()
    autoload.check_and_load(
        playerMgr, targetMgr, partyMgr, jobNames, known_bosses,
        load_job_triggers, load_boss_triggers,
        debug_log_loaded
    )
end)

