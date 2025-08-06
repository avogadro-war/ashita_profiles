require('common')
local struct = require('struct')
local trackedKeyItems = require('tracked_key_items')
local key_items = require('key_items_optimized')
local chat = require('chat')

-- Settings fallback system
local settings = {}
local settings_file = 'data/keyring_settings.json'

-- Try to load external settings module, fallback to internal implementation
local success, external_settings = pcall(require, 'settings')
if success and external_settings then
    settings = external_settings
    print(chat.header('Keyring'):append(chat.message('Settings module loaded successfully.')))
else
    -- Internal settings implementation
    local json_success, json = pcall(require, 'json')
    
    if json_success and json then
        print(chat.header('Keyring'):append(chat.message('Using JSON-based settings storage.')))
        function settings.load(defaults)
            local file = io.open(settings_file, 'r')
            if file then
                local content = file:read('*all')
                file:close()
                local success, data = pcall(json.decode, content)
                if success and data then
                    return data
                end
            end
            return defaults or {}
        end
        
        function settings.save(data)
            local dir = string.match(settings_file, '(.+)/[^/]*$')
            if dir then
                os.execute('mkdir -p "' .. dir .. '"')
            end
            local file = io.open(settings_file, 'w')
            if file then
                file:write(json.encode(data))
                file:close()
            end
        end
    else
        -- Fallback to in-memory storage only (no persistence)
        print(chat.header('Keyring'):append(chat.message('Warning: Settings module not available. Data will not persist between sessions.')))
        
        function settings.load(defaults)
            return defaults or {}
        end
        
        function settings.save(data)
            -- No-op: data is not persisted
        end
    end
end

local handler = {}

-- Debug flag
local debugMode = false

-- Debug helper function
local function debug_print(message)
    if debugMode then
        print(chat.header('Keyring Debug'):append(chat.message(message)))
    end
end

-- Internal state persistence
local state = settings.load and settings.load({
    timestamps = {},
    owned = {},
    last_storage = 0,
    storage_canteens = 0,
    last_canteen_time = 0
}) or {
    timestamps = {},
    owned = {},
    last_storage = 0,
    storage_canteens = 0,
    last_canteen_time = 0
}

-- Callback hooks
local currency_callback = nil
local zone_callback = nil

-- Internal flags
local firstCanteenCheck = false

--Init vars
local mem = AshitaCore:GetMemoryManager()
local player = mem:GetPlayer()

--HasKeyItem check
local function has_key_item(id)
    return player:HasKeyItem(id)
end

-- Request Storage Slip Canteen info (outgoing packet 0x115)
local function request_currency_data()
    local packet = struct.pack('bbbb', 0x15, 0x03, 0x00, 0x00):totable()
    AshitaCore:GetPacketManager():AddOutgoingPacket(0x115, packet)
end

-- Called when a tracked key item is acquired
local function update_keyitem_state(id)
    local now = os.time()
    debug_print(string.format('update_keyitem_state called for ID %d at time %d', id, now))
    
    -- Only update timestamp if we didn't have this item before
    if not state.owned[id] then
        state.timestamps[id] = now
        debug_print(string.format('Updated timestamp for newly acquired key item ID %d', id))
    else
        debug_print(string.format('Key item ID %d already owned, not updating timestamp', id))
    end
    
    state.owned[id] = true

    if id == 3137 then
        state.last_canteen_time = now
        -- Immediately poll canteen storage after acquisition for accuracy
        debug_print('Canteen acquired - polling storage immediately...')
        request_currency_data()
    end

    if settings.save then
        settings.save(state)
    end
    debug_print(string.format('State updated: owned=%s, timestamp=%d', tostring(state.owned[id]), state.timestamps[id]))
end

-- API: Register callback for storage canteen updates
function handler.set_currency_callback(cb)
    currency_callback = cb
end

-- API: Register callback for zone change
function handler.set_zone_change_callback(cb)
    zone_callback = cb
end

-- API: Is a key item currently held?
function handler.has_key_item(id)
    return state.owned[id] == true
end

-- API: Get timestamp for acquisition
function handler.get_timestamp(id)
    if not id or type(id) ~= 'number' then
        debug_print('get_timestamp: Invalid ID provided')
        return 0
    end
    return state.timestamps[id] or 0
end

-- API: Get all timestamps
function handler.get_timestamps()
    return state.timestamps
end

-- API: Get cooldown remaining
function handler.get_remaining(id)
    if not id or type(id) ~= 'number' then
        debug_print('get_remaining: Invalid ID provided')
        return 0
    end
    
    local cooldown = trackedKeyItems[id]
    local ts = state.timestamps[id]
    if not cooldown or not ts then 
        debug_print(string.format('get_remaining: No cooldown or timestamp for ID %d', id))
        return 0 
    end
    return math.max(0, (ts + cooldown) - os.time())
end

-- Cache for storage canteen calculations
local storage_cache = {
    last_calc_time = 0,
    cached_count = 0,
    cache_duration = 5 -- Cache for 5 seconds
}

local function update_storage_canteens()
    local currentTime = os.time()
    
    -- Check if cache is still valid
    if currentTime - storage_cache.last_calc_time < storage_cache.cache_duration then
        return storage_cache.cached_count
    end
    
    local canteens = state.storage_canteens or 0
    local lastTime = state.last_canteen_time or 0
    local cooldown = 72000 -- 20 hours in seconds

    if lastTime > 0 and canteens < 3 then
        local elapsed = currentTime - lastTime
        local accrued = math.floor(elapsed / cooldown)
        if accrued > 0 then
            canteens = math.min(canteens + accrued, 3)
            state.storage_canteens = canteens

            if canteens < 3 then
                state.last_canteen_time = lastTime + accrued * cooldown
            else
                state.last_canteen_time = 0
            end

            if settings.save then
                settings.save(state)
            end
        end
    end
    
    -- Update cache
    storage_cache.last_calc_time = currentTime
    storage_cache.cached_count = canteens
    
    return canteens
end


-- API: Is key item cooldown expired?
function handler.is_available(id)
    local cooldown = trackedKeyItems[id]
    local ts = state.timestamps[id]
    if not cooldown then return nil end
    return os.time() >= (ts + cooldown)
end

-- API: Last storage time / count
function handler.get_storage_info()
    return {
        count = state.storage_canteens or 0,
        last_storage = state.last_storage or 0
    }
end

-- API: Get last canteen time
function handler.get_canteen_timestamp()
    return state.last_canteen_time or 0
end

function handler.save_state()
    if settings.save then
        settings.save(state)
    end
end

-- API: Update owned state (called from main addon)
function handler.update_owned_state(id, owned)
    if owned then
        -- If we're marking it as owned and it wasn't owned before, update timestamp
        if not state.owned[id] then
            debug_print(string.format('update_owned_state: Marking ID %d as owned', id))
            update_keyitem_state(id)
        end
    else
        -- If we're marking it as not owned, clear the owned state but keep timestamp
        state.owned[id] = false
        if settings.save then
            settings.save(state)
        end
    end
end

-- PACKET HOOKS --

-- Key item list (0x55) - Using Thorny's approach
ashita.events.register('packet_in', 'KeyItems_0x55', function(e)
    if e.id ~= 0x55 then return end

    debug_print('Received 0x55 packet - checking for tracked key items...')

    local offset = struct.unpack('B', e.data, 0x84 + 1) * 512
    debug_print(string.format('Packet covers KIs %d to %d', offset, offset + 511))

    for ki, _ in pairs(trackedKeyItems) do
        if (ki >= offset) and (ki <= offset + 511) then
            local hasKeyItem = (ashita.bits.unpack_be(e.data_raw, 0x04, ki - offset, 1) == 1)
            local wasOwned = state.owned[ki] == true
            
            debug_print(string.format('KI %d: packet says %s, was %s', ki, hasKeyItem and 'Have' or 'Dont', wasOwned and 'Have' or 'Dont'))
            
            if hasKeyItem and not wasOwned then
                -- Always show key item acquisition (not debug-only)
                print(chat.header('Keyring'):append(chat.message(string.format('Acquired tracked key item: %s', key_items.idToName[ki] or ('ID ' .. ki)))))
                update_keyitem_state(ki)
            elseif not hasKeyItem and wasOwned then
                debug_print(string.format('Key item ID %d no longer owned', ki))
                state.owned[ki] = false
                if settings.save then
                    settings.save(state)
                end
            end
        end
    end
end)

--Zoning complete (0x0A)
ashita.events.register('packet_in', 'Keyring_0x0A', function(e)
    if e.id ~= 0x0A then return end

    local notifyTime = os.time() + 6
    local checkPending = true
    local notified = false

    if zone_callback then
        zone_callback(notifyTime, checkPending, notified)
    end

    if not firstCanteenCheck then
        debug_print('Requesting currency data...')
        request_currency_data()
        firstCanteenCheck = true
    end
end)

ashita.events.register('packet_in', 'Keyring_0x118', function(e)
    if e.id ~= 0x118 then return end

    local canteenCount = e.data:byte(12) or 0 
    canteenCount = math.min(canteenCount, 3)
    
    local previousCount = state.storage_canteens or 0
    
    -- Check if canteens increased (indicating acquisition)
    if canteenCount > previousCount then
        debug_print(string.format('Canteen count increased from %d to %d - inferring acquisition', previousCount, canteenCount))
        
        -- Update canteen timestamp for Mystical Canteen (ID 3137)
        local canteenId = 3137
        if not state.timestamps[canteenId] or state.timestamps[canteenId] == 0 then
            -- For canteen increases after idle periods, we can't determine exact acquisition time
            -- Instead, we'll use a conservative approach that doesn't set a timestamp
            -- and let the user manually acquire the canteen to get an accurate timestamp
            
            debug_print('Canteen increase detected but cannot determine exact acquisition time')
            debug_print('Recommendation: Acquire canteen manually to get accurate timestamp')
            
            -- Don't set a timestamp - let the user acquire it manually for accuracy
            -- This prevents inaccurate cooldown tracking
            state.owned[canteenId] = true
            
            -- Show informative message
            print(chat.header('Keyring'):append(chat.message('Canteen storage increased but exact acquisition time unknown.')))
            print(chat.header('Keyring'):append(chat.message('Please acquire a canteen manually to start accurate tracking.')))
        end
    end

    state.storage_canteens = canteenCount
    state.last_storage = os.time()

    update_storage_canteens() -- keep timer consistent

    if currency_callback then
        currency_callback(canteenCount)
    end

    if settings.save then
        settings.save(state)
    end
end)

-- Automatic refresh after zoning
local zone_timer = 0
local zone_delay = 5

ashita.events.register('packet_in', 'ZoneStartTimer_0x0A', function(e)
    if e.id == 0x0A then
        zone_timer = os.time()
    end
end)

ashita.events.register('d3d_present', 'ZoneTimer', function()
    if zone_timer > 0 and (os.time() - zone_timer >= zone_delay) then
        zone_timer = 0

        -- Now do your delayed HasKeyItem check here
        for id, _ in pairs(trackedKeyItems) do
            local currently_owned = has_key_item(id)
            local was_owned = state.owned[id] == true
            
            if currently_owned and not was_owned then
                debug_print(string.format('Zone check: Found newly acquired key item ID %d!', id))
                update_keyitem_state(id)
            elseif not currently_owned and was_owned then
                debug_print(string.format('Zone check: Key item ID %d no longer owned', id))
                state.owned[id] = false
                if settings.save then
                    settings.save(state)
                end
            end
        end
    end
end)

function handler.get_key_item_statuses()
    local result = {}

    for id, cooldown in pairs(trackedKeyItems) do
        local timestamp = state.timestamps[id] or 0

        if type(timestamp) ~= 'number' then
            timestamp = tonumber(timestamp) or 0
        end

        local remaining = (timestamp + cooldown) - os.time()

        local name = key_items.idToName[id] or ('Unknown ID: ' .. tostring(id))

        table.insert(result, {
            id = id,
            name = name,
            remaining = remaining,
        })
    end

    return result
end

-- API: Set debug mode
function handler.set_debug_mode(enabled)
    debugMode = enabled
    debug_print("Debug mode " .. (enabled and "enabled" or "disabled") .. " in packet handler")
end

return handler