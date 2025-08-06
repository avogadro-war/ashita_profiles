addon.author   = 'Avogadro, assistance from Thorny and Will'
addon.name     = 'Keyring'
addon.version  = '0.1'

require('common')
local chat = require('chat')
local imgui = require('imgui')
local trackedKeyItems = require('tracked_key_items')
local key_items = require('key_items_optimized')
local packet_tracker = require('keyring_packet_handler')

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
local showGui = { false }
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
        showGui[1] = not showGui[1]
        print(chat.header('Keyring'):append(chat.message('GUI ' .. (showGui[1] and 'toggled on.' or 'toggled off.'))))
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
    if not showGui[1] then return end

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



    -- Dynamic window sizing based on actual content
    local keyItemStatuses = packet_tracker.get_key_item_statuses()
    local itemCount = #keyItemStatuses
    
    -- Dynamic height calculation - more precise measurements
    local headerHeight = 30  -- Header height including separator
    local itemHeight = 22    -- Height per item (more precise)
    local spacingHeight = 2  -- Minimal spacing between items
    local padding = 35       -- Reduced window padding
    local minHeight = 100    -- Minimum height for empty/small lists
    
    -- Calculate exact height needed
    local spacingCount = math.max(0, itemCount - 1)  -- No spacing after last item
    local contentHeight = headerHeight + (itemCount * itemHeight) + (spacingCount * spacingHeight)
    local requiredHeight = math.max(contentHeight + padding, minHeight)
    
    -- Dynamic width calculation based on content
    local minWidth = 450
    local maxWidth = 1200  -- Allow wider for longer item names
    local baseWidth = 500
    
    -- Check if we have long item names and adjust width accordingly
    local maxNameLength = 0
    for _, item in ipairs(keyItemStatuses) do
        if item.name and #item.name > maxNameLength then
            maxNameLength = #item.name
        end
    end
    
    -- Adjust width based on longest name (approximate character width)
    local dynamicWidth = math.min(math.max(baseWidth + (maxNameLength * 6), minWidth), maxWidth)
    
    -- Set dynamic window constraints - this will resize the window automatically
    imgui.SetNextWindowSizeConstraints({dynamicWidth, requiredHeight}, {dynamicWidth, requiredHeight})

    if not imgui.Begin('Key Item Cooldowns', showGui) then
        imgui.End()
        return
    end

    imgui.Columns(4, 'cooldownColumns', true)
    local total_width = imgui.GetWindowContentRegionWidth()

    -- Responsive column widths with minimum sizes
    local minNameWidth = 180
    local minStatusWidth = 70
    local minCooldownWidth = 70
    local minTimeWidth = 140
    
    local nameWidth = math.max(total_width * 0.45, minNameWidth)
    local statusWidth = math.max(total_width * 0.15, minStatusWidth)
    local cooldownWidth = math.max(total_width * 0.15, minCooldownWidth)
    local timeWidth = math.max(total_width * 0.25, minTimeWidth)
    
    imgui.SetColumnWidth(0, nameWidth)      -- Key Item
    imgui.SetColumnWidth(1, statusWidth)    -- Have?
    imgui.SetColumnWidth(2, cooldownWidth)  -- Cooldown
    imgui.SetColumnWidth(3, timeWidth)      -- Time Remaining

    local function center_text(text)
        local col_start = imgui.GetColumnOffset()
        local col_width = imgui.GetColumnWidth()
        local text_width = imgui.CalcTextSize(text)
        local pos_x = col_start + (col_width - text_width) / 2
        imgui.SetCursorPosX(pos_x)
        imgui.Text(text)
    end

    -- Headers
    center_text('Key Item')
    imgui.NextColumn()
    center_text('Have?')
    imgui.NextColumn()
    center_text('Cooldown')
    imgui.NextColumn()
    center_text('Time Remaining')
    imgui.NextColumn()
    imgui.Separator()

    local keyItemStatuses = packet_tracker.get_key_item_statuses()

    for i, item in ipairs(keyItemStatuses) do
        local id = item.id
        local name = item.name
        local remaining = item.remaining or 0
        local cooldown = trackedKeyItems[id] or 0

        -- Key Item Name (left aligned)
        imgui.Text(name)
        imgui.NextColumn()

        -- Have? (centered, colored)
        local hasItem = has_key_item(id)
        local statusText = hasItem and 'Yes' or 'No'
        local statusColor = hasItem and {0, 1, 0, 1} or {1, 0.2, 0.2, 1}
        do
            local col_start = imgui.GetColumnOffset()
            local col_width = imgui.GetColumnWidth()
            local text_width = imgui.CalcTextSize(statusText)
            local pos_x = col_start + (col_width - text_width) / 2
            imgui.SetCursorPosX(pos_x)
            imgui.TextColored(statusColor, statusText)
        end
        imgui.NextColumn()

        -- Cooldown (centered)
        local cd_h = math.floor(cooldown / 3600)
        local cooldownText = string.format('%dh', cd_h)
        do
            local col_start = imgui.GetColumnOffset()
            local col_width = imgui.GetColumnWidth()
            local text_width = imgui.CalcTextSize(cooldownText)
            local pos_x = col_start + (col_width - text_width) / 2
            imgui.SetCursorPosX(pos_x)
            imgui.Text(cooldownText)
        end
        imgui.NextColumn()

        -- Time Remaining (centered, with canteen special case)
        do
            local displayText
            local textColor = {1, 0.2, 0.2, 1} -- red default
            local showCanteenCount = (id == 3137)
            
            -- Check if we have a timestamp for this item
            local timestamp = packet_tracker.get_timestamp(id) or 0
            
            if timestamp == 0 then
                -- No timestamp recorded yet
                textColor = {0.7, 0.7, 0.7, 1} -- gray
                displayText = 'Unknown'
            elseif remaining <= 0 then
                textColor = {0, 1, 0, 1} -- green
                displayText = 'Available'
            else
                local rh = math.floor(remaining / 3600)
                local rm = math.floor((remaining % 3600) / 60)
                local rs = remaining % 60
                displayText = string.format('%02dh:%02dm:%02ds', rh, rm, rs)
            end

            -- Calculate positioning for centered text
            local col_start = imgui.GetColumnOffset()
            local col_width = imgui.GetColumnWidth()
            
            if showCanteenCount then
                -- For canteen, render main text and count separately
                local mainTextWidth = imgui.CalcTextSize(displayText)
                local canteenText = string.format(' (%d/3)', storageCanteens)
                local canteenTextWidth = imgui.CalcTextSize(canteenText)
                local totalWidth = mainTextWidth + canteenTextWidth
                local pos_x = col_start + (col_width - totalWidth) / 2
                
                -- Render main status text
                imgui.SetCursorPosX(pos_x)
                imgui.TextColored(textColor, displayText)
                
                -- Render canteen count in white
                imgui.SameLine()
                imgui.TextColored({1, 1, 1, 1}, canteenText)
            else
                -- For non-canteen items, render normally
                local text_width = imgui.CalcTextSize(displayText)
                local pos_x = col_start + (col_width - text_width) / 2
                imgui.SetCursorPosX(pos_x)
                imgui.TextColored(textColor, displayText)
            end

            if imgui.IsItemHovered() then
                imgui.BeginTooltip()
                if timestamp == 0 then
                    imgui.Text('No acquisition time recorded yet.')
                    imgui.Text('Acquire the item to start tracking.')
                elseif remaining <= 0 then
                    if id == 3137 and storageCanteens == 3 then
                        imgui.Text('Timer paused: Max canteens stored.')
                    else
                        imgui.Text('Available now.')
                    end
                else
                    imgui.Text('Still on cooldown.')
                end
                imgui.EndTooltip()
            end
                 end
         imgui.NextColumn()
         
         -- Add some spacing between rows
         if i < #keyItemStatuses then
             imgui.Spacing()
         end
     end

     imgui.Columns(1)
     imgui.End()
end)