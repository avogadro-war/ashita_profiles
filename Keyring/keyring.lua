addon.author   = 'Avogadro, assistance from Thorny and Will'
addon.name     = 'Keyring'
addon.version  = '0.2'

require('common')
local chat = require('chat')
local trackedKeyItems = require('tracked_key_items')
local key_items = require('key_items_optimized')
local packet_tracker = require('keyring_packet_handler')
local gui = require('keyring_gui')

-- Local copies of canteen state, updated via callback
local storageCanteens = 0

packet_tracker.set_currency_callback(function(canteens)
    storageCanteens = canteens
end)

-- Set up zone change callback
packet_tracker.set_zone_change_callback(function(notifyTime, checkPending, notified)
    zoneNotifyTime = notifyTime
    zoneCheckPending = checkPending
    zoneNotified = notified
    
    -- Check for available key items after zoning (if notifications are enabled)
    if notificationEnabled then
        local availableItems = {}
        for id, _ in pairs(trackedKeyItems) do
            local timestamp = packet_tracker.get_timestamp(id) or 0
            local remaining = packet_tracker.get_remaining(id) or 0
            local hasItem = has_key_item(id)
            
            -- Only notify if: has timestamp, is available (remaining <= 0), and player doesn't have it
            if timestamp > 0 and remaining <= 0 and not hasItem then
                local itemName = key_items.idToName[id] or ('ID ' .. tostring(id))
                table.insert(availableItems, itemName)
            end
        end
        
        if #availableItems > 0 then
            local itemList = table.concat(availableItems, ', ')
            print(chat.header('Keyring'):append(chat.message(string.format('Available for pickup: %s', itemList))))
        end
    end
end)

-- GUI state and timing
local lastCanteenTime = 0
local lastStorageUpdate = 0

-- Zone notification variables
local zoneCheckPending = false
local zoneNotifyTime = 0
local zoneNotified = false

-- Debug flag
local debugMode = false
local notificationEnabled = true

-- Debug helper function
local function debug_print(message)
    if debugMode then
        print(chat.header('Keyring Debug'):append(chat.message(message)))
    end
end

-- Set debug mode in packet handler
local function update_debug_mode()
    if packet_tracker.set_debug_mode then
        packet_tracker.set_debug_mode(debugMode)
    end
end

local function has_key_item(id)
    return packet_tracker.has_key_item(id)
end

local function update_storage_canteens()
    local currentTime = os.time()

    -- Sync with packet tracker state
    lastCanteenTime = packet_tracker.get_canteen_timestamp() or 0
    storageCanteens = packet_tracker.get_storage_info().count or 0

    if lastCanteenTime > 0 and storageCanteens < 3 then
        local timeSinceLast = currentTime - lastCanteenTime
        local canteensAccrued = math.floor(timeSinceLast / 72000)

        if canteensAccrued > 0 then
            storageCanteens = math.min(storageCanteens + canteensAccrued, 3)
            if storageCanteens < 3 then
                lastCanteenTime = lastCanteenTime + canteensAccrued * 72000
            else
                lastCanteenTime = 0
            end
        end
    end
end

local function is_item_available(id)
    if id == 3137 then
        if storageCanteens >= 3 or lastCanteenTime == 0 then
            return true
        end
        local remaining = (lastCanteenTime + trackedKeyItems[id]) - os.time()
        return remaining <= 0
    else
        return packet_tracker.is_available(id)
    end
end

ashita.events.register('command', 'command_cb', function(e)
    local args = e.command:lower():split(' ')
    if args[1] ~= '/keyring' then return false end

    -- Toggle the GUI if no extra args or 'gui'
    if args[2] == nil or args[2] == '' or args[2] == 'gui' then
        local isVisible = gui.toggle()
        print(chat.header('Keyring'):append(chat.message('GUI ' .. (isVisible and 'toggled on.' or 'toggled off.'))))
        return true
    end

    -- Debug toggle
    if args[2] == 'debug' then
        debugMode = not debugMode
        update_debug_mode()
        print(chat.header('Keyring'):append(chat.message('Debug mode ' .. (debugMode and 'enabled.' or 'disabled.'))))
        if debugMode then
            print(chat.header('Keyring'):append(chat.message('Debug messages will now be shown in chat.')))
        end
        return true
    end

    -- Notification toggle
    if args[2] == 'notify' then
        notificationEnabled = not notificationEnabled
        print(chat.header('Keyring'):append(chat.message('Notifications ' .. (notificationEnabled and 'enabled.' or 'disabled.'))))
        return true
    end

    -- Check command
    if args[2] == 'check' then
        local availableItems = {}
        for id, _ in pairs(trackedKeyItems) do
            local timestamp = packet_tracker.get_timestamp(id) or 0
            local remaining = packet_tracker.get_remaining(id) or 0
            local hasItem = has_key_item(id)
            
            -- Only show if: has timestamp, is available (remaining <= 0), and player doesn't have it
            if timestamp > 0 and remaining <= 0 and not hasItem then
                local itemName = key_items.idToName[id] or ('ID ' .. tostring(id))
                table.insert(availableItems, itemName)
            end
        end
        
        if #availableItems > 0 then
            local itemList = table.concat(availableItems, ', ')
            print(chat.header('Keyring'):append(chat.message(string.format('Available for pickup: %s', itemList))))
        else
            print(chat.header('Keyring'):append(chat.message('No key items are currently available for pickup.')))
        end
        return true
    end

    -- Help command
    if args[2] == 'help' then
        print(chat.header('Keyring'):append(chat.message('Keyring Addon - Key Item Cooldown Tracker')))
        print(chat.message(''))
        print(chat.message('This addon tracks key items with cooldown timers:'))
        print(chat.message('  • Moglophone (20h cooldown)'))
        print(chat.message('  • Mystical Canteen (20h cooldown)'))
        print(chat.message('  • Shiny Rakaznar Plate (20h cooldown)'))
        print(chat.message(''))
        print(chat.message('Available commands:'))
        print(chat.message('  /keyring or /keyring gui - Toggle the GUI window'))
        print(chat.message('  /keyring debug - Toggle debug messages in chat'))
        print(chat.message('  /keyring check - Check for available key items'))
        print(chat.message('  /keyring notify - Toggle zone change notifications'))
        print(chat.message('  /keyring help - Show this help information'))
        print(chat.message(''))
        print(chat.message('Features:'))
        print(chat.message('  • Automatic detection of key item acquisition'))
        print(chat.message('  • Real-time cooldown tracking'))
        print(chat.message('  • Zone change notifications'))
        print(chat.message('  • Special canteen storage tracking'))
        print(chat.message('  • Persistent state across sessions'))
        print(chat.message('  • Shows "Unknown" until first acquisition'))
        print(chat.message('  • Notifications for available items on zone change'))
        return true
    end

    -- Unknown command
    print(chat.header('Keyring'):append(chat.message('Unknown command. Type /keyring help for available commands.')))
    return true
end)

ashita.events.register('load', 'load_cb', function()
    local loadTime = os.time()
    ashita.events.register('d3d_present', 'LoadDelayTimer', function()
        local playerName = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

        if playerName ~= nil and playerName ~= '' then
            ashita.events.unregister('d3d_present', 'LoadDelayTimer')
            
            for id, _ in pairs(trackedKeyItems) do
                local owned = has_key_item(id)
                if packet_tracker.update_owned_state then
                    packet_tracker.update_owned_state(id, owned)
                end
            end
            
            print(chat.header('Keyring'):append(chat.message('Initialized key item owned state from memory after addon load.')))
            packet_tracker.save_state()
        elseif os.time() - loadTime > 10 then
            ashita.events.unregister('d3d_present', 'LoadDelayTimer')
            print(chat.header('Keyring'):append(chat.message('Failed to initialize: player data not ready after 10 seconds.')))
        end
    end)
end)

ashita.events.register('d3d_present', 'render', function()
    local currentTime = os.time()
    if currentTime - lastStorageUpdate > 5 then
        update_storage_canteens()
        lastStorageUpdate = currentTime
    end

    if zoneCheckPending and currentTime >= zoneNotifyTime and not zoneNotified then
        local notifyNeeded = false
        for id in pairs(trackedKeyItems) do
            if is_item_available(id) and not has_key_item(id) then
                notifyNeeded = true
                break
            end
        end

        if notifyNeeded then
            print(chat.header('Keyring'):append(chat.message('One or more key items are available for pickup! /keyring to check.')))
        end

        zoneNotified = true
        zoneCheckPending = false
    end



    -- Render the GUI using the modularized GUI system
    local keyItemStatuses = packet_tracker.get_key_item_statuses()
    gui.render(keyItemStatuses, has_key_item, trackedKeyItems, storageCanteens)

end)