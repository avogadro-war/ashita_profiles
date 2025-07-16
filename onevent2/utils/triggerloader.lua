-- trigger_loader.lua
local statusIDs = require('utils.statusIDs')

-- Build reverse lookup (optional, useful for debug)
local statusID_to_names = {}
for name, id in pairs(statusIDs) do
    statusID_to_names[id] = statusID_to_names[id] or {}
    table.insert(statusID_to_names[id], name)
end

local function normalize_trigger_table(trigger_table, table_name)
    local normalized = {}
    for key, value in pairs(trigger_table or {}) do
        local id = tonumber(key)
        if not id then
            local lookup = statusIDs[key:lower()]
            if lookup then
                id = lookup
            else
                print(('[onevent2] Warning: Unknown buff/debuff name in %s: "%s"'):format(table_name, tostring(key)))
            end
        end
        if id then
            normalized[id] = value
        end
    end
    return normalized
end

local function load_and_normalize_triggers(path)
    local ok, triggers = pcall(require, path)
    if not ok then
        print(('[onevent2] Failed to load trigger file: %s'):format(path))
        return nil
    end

    local normalized = {}
    normalized.buffgain_alerts     = normalize_trigger_table(triggers.buffgain_alerts, 'buffgain_alerts')
    normalized.bufflose_alerts     = normalize_trigger_table(triggers.bufflose_alerts, 'bufflose_alerts')
    normalized.debuffexpire_alerts = normalize_trigger_table(triggers.debuffexpire_alerts, 'debuffexpire_alerts')
    normalized.chat_triggers       = triggers.chat_triggers -- keep as-is

    return normalized
end

return {
    load_and_normalize_triggers = load_and_normalize_triggers
}