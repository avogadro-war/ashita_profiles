--[[
* Onevent Addon - Auto-load by job & boss, toggle, merge, remove
* Author: atom0s + extended by Avogadro
* Reacts to chat by running commands & sounds; auto-loads triggers by job/boss.
--]]

addon.name    = 'onevent2';
addon.author  = 'atom0s + Avogadro';
addon.version = '4.0';
addon.desc    = 'Reacts to chat with commands, sounds; auto-loads job/boss triggers.';
addon.link    = 'https://ashitaxi.com/';

require('common');
local chat = require('chat');

--------------------------------------------------------------------------------
-- 📦 State
--------------------------------------------------------------------------------
local onevent = {
    job_triggers  = T{},
    boss_triggers = T{},
    last_job      = nil,
    last_boss     = nil,
    paused        = false,
    auto_load     = true,  -- starts enabled
};

--------------------------------------------------------------------------------
-- 🛠 Helpers
--------------------------------------------------------------------------------
local function pause() onevent.paused = true; end
local function unpause() onevent.paused = false; end

function string.startswith(s, start)
    return s:sub(1, #start) == start
end

function string.trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function string.split(s, sep)
    local t={} for str in string.gmatch(s, "([^"..sep.."]+)") do table.insert(t, str) end
    return t
end

--------------------------------------------------------------------------------
-- 📦 Loaders
--------------------------------------------------------------------------------
local function load_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, triggers = pcall(dofile, path)
    if ok and type(triggers) == 'table' then
        local oldCount = #onevent.job_triggers
        onevent.job_triggers = T(triggers)
        print(chat.header(addon.name):append(chat.message(('Loaded job triggers: %s (replaced %d)'):fmt(chat.success(setname), oldCount))))
    else
        print(chat.header(addon.name):append(chat.error(('Failed to load job trigger set: %s'):fmt(chat.success(setname)))))
    end
end

local function merge_job_triggers(setname)
    local path = string.format('%striggers/jobs/%s.lua', addon.path, setname)
    local ok, triggers = pcall(dofile, path)
    if ok and type(triggers) == 'table' then
        local oldCount = #onevent.job_triggers
        triggers:ieach(function (v) table.insert(onevent.job_triggers, v) end)
        print(chat.header(addon.name):append(chat.message(('Merged %d triggers into job triggers; total now: %d'):fmt(#triggers, #onevent.job_triggers))))
    else
        print(chat.header(addon.name):append(chat.error(('Failed to merge job trigger set: %s'):fmt(chat.success(setname)))))
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

--------------------------------------------------------------------------------
-- 📢 Help
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
        { '/onevent removeall', 'Remove all boss triggers.' },
        { '/onevent removejoball', 'Remove all job triggers.' },
        { '/onevent removebossall', 'Remove all boss triggers.' },
        { '/onevent list', 'List current job & boss triggers separately.' },
        { '/onevent loadjob <setname>', 'Load job triggers (replace).' },
        { '/onevent mergejob <setname>', 'Merge triggers into job triggers.' },
        { '/onevent loadboss <setname>', 'Load boss triggers (replace).' },
        { '/onevent auto on|off', 'Enable/disable auto-load feature.' },
        { '/onevent help', 'Show help.' },
    }

    cmds:ieach(function (v)
        print(chat.header(addon.name):append(chat.error('Usage: ')):append(chat.message(v[1]):append(' - ')):append(chat.color1(6, v[2])))
    end)
end

--------------------------------------------------------------------------------
-- ✏ Parse /onevent add
--------------------------------------------------------------------------------
local function split_cmd(cmd)
    local cleaned = cmd:sub(cmd:find('/onevent add') and 14 or 9)
    local t, a = cleaned:match('([^,]+)%s*|%s*(.+)')
    return t and t:trim(), a and a:trim()
end

--------------------------------------------------------------------------------
-- 🧠 Command handler
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

    if sub == 'removejoball' then
        local old = #onevent.job_triggers
        onevent.job_triggers = T{}
        print(chat.header(addon.name):append(chat.message(('Removed %d job triggers.'):fmt(old))))
        return
    end

    if sub == 'list' then
        print(chat.header(addon.name):append(chat.message('--- Job Triggers ---')))
        if #onevent.job_triggers == 0 then print(chat.message('None')) else
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
        return
    end

    if sub == 'loadjob' and #args >= 3 then load_job_triggers(args[3]); return end
    if sub == 'mergejob' and #args >= 3 then merge_job_triggers(args[3]); return end
    if sub == 'loadboss' and #args >= 3 then load_boss_triggers(args[3]); return end

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

    print_help(true)
end

--------------------------------------------------------------------------------
-- 📡 Command event
--------------------------------------------------------------------------------
ashita.events.register('command', 'command_cb', function (e)
    local args = e.command:args()
    if #args >= 1 and not (args[1]:ieq('/onevent') or args[1]:ieq('/oe')) then return end
    e.blocked = true
    if #args <= 1 then return end
    (function() end):dispatch(pause, cmd, unpause)(e, args)
end)

--------------------------------------------------------------------------------
-- 📩 Text in event
--------------------------------------------------------------------------------
ashita.events.register('text_in', 'text_in_cb', function (e)
    -- Don't do anything while paused
    if onevent.paused then return end

    -- Helper: run all triggers in a given trigger table
    local function process_triggers(triggers)
        triggers:ieach(function (v)
            if e.message_modified:contains(v[1]) then
                local actions = v[2]:split(';')
                for _, act in ipairs(actions) do
                    act = act:trim()
                    if act:startswith('sound:') then
                        local soundFile = act:sub(7):trim()
                        -- Build full path: addon.path points to your addon folder
                        local soundPath = string.format('%ssounds\\%s', addon.path, soundFile)
                        print(chat.header(addon.name):append(chat.message('Playing sound: ' .. addon.path .. 'sounds\\mgs.wav')))
                        ashita.misc.play_sound(soundPath)
                    else
                        -- Defensive: get chat manager safely
                        local chatManager = AshitaCore and AshitaCore:GetChatManager()
                        if chatManager then
                            chatManager:QueueCommand(1, act)
                        else
                            print(chat.header(addon.name):append(chat.error('ChatManager unavailable; could not run command: ' .. act)))
                        end
                    end
                end
            end
        end)
    end

    -- Process both job and boss triggers
    process_triggers(onevent.job_triggers)
    process_triggers(onevent.boss_triggers)

end)


--------------------------------------------------------------------------------
-- 🧠 Auto-load by job & target
--------------------------------------------------------------------------------
local known_bosses = {
    ['Lilith'] = 'lilith',
    ['Odin']   = 'odin',
    ['Glassy Thinker'] = 'thinker',
    -- Add more as needed
}
local jobNames = {
    [1]='WAR',[2]='MNK',[3]='WHM',[4]='BLM',[5]='RDM',[6]='THF',
    [7]='PLD',[8]='DRK',[9]='BST',[10]='BRD',[11]='RNG',[12]='SAM',
    [13]='NIN',[14]='DRG',[15]='SMN',[16]='BLU',[17]='COR',[18]='PUP',
    [19]='DNC',[20]='SCH',[21]='GEO',[22]='RUN'
}

local last_check = os.clock()
ashita.events.register('d3d_present', 'auto_load_check', function ()
    if not onevent.auto_load then return end
    if os.clock() - last_check < 2 then return end
    last_check = os.clock()

    -- Auto-load by job
    local player = AshitaCore:GetMemoryManager():GetPlayer()
    local jobId = player and player:GetMainJob()
    local job = jobId and jobNames[jobId]
    if job and job ~= onevent.last_job then
        local filename = string.format('%s_triggers', job:lower())
        load_job_triggers(filename)
        print(chat.header(addon.name):append(chat.message(('Auto-loaded job triggers: %s'):fmt(job))))
        onevent.last_job = job
    end

    -- Auto-load by boss target
    local targetName = nil  -- local variable to avoid globals

    local mem = AshitaCore:GetMemoryManager()
    if not mem then return end

    local targetMgr = mem:GetTarget()
    local entityMgr = mem:GetEntity()
    if not targetMgr or not entityMgr or type(entityMgr.GetEntity) ~= 'function' then return end

    local targetIndex = targetMgr:GetTargetIndex(0)
    if targetIndex and targetIndex > 0 then
        -- Use pcall to protect against errors in GetEntity
        local ok, entity = pcall(entityMgr.GetEntity, entityMgr, targetIndex)
        if ok and entity and type(entity.Name) == 'string' then
            targetName = entity.Name
        end
    end

    if targetName and targetName ~= '' and targetName ~= onevent.last_boss then
        local trigger_file = known_bosses[targetName]
        if trigger_file then
            load_boss_triggers(trigger_file)
            print(chat.header(addon.name):append(chat.message(('Auto-loaded boss triggers: %s'):fmt(targetName))))
            onevent.last_boss = targetName
        end
    end

end)