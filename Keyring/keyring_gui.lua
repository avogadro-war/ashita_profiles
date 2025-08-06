-- Keyring GUI Module
-- Handles all ImGui rendering logic for the keyring addon

local imgui = require('imgui')
local chat = require('chat')

local gui = {}

-- GUI state
local showGui = { false }

-- Dynamic window sizing constants
local HEADER_HEIGHT = 30
local ITEM_HEIGHT = 22
local SPACING_HEIGHT = 2
local PADDING = 35
local MIN_HEIGHT = 100
local MIN_WIDTH = 450
local MAX_WIDTH = 1200
local BASE_WIDTH = 500

function gui.is_visible()
    return showGui[1]
end

function gui.toggle()
    showGui[1] = not showGui[1]
    return showGui[1]
end

function gui.set_visible(visible)
    showGui[1] = visible
end

-- Calculate dynamic window dimensions based on content
local function calculate_window_dimensions(keyItemStatuses)
    local itemCount = #keyItemStatuses
    
    -- Calculate height
    local spacingCount = math.max(0, itemCount - 1)
    local contentHeight = HEADER_HEIGHT + (itemCount * ITEM_HEIGHT) + (spacingCount * SPACING_HEIGHT)
    local requiredHeight = math.max(contentHeight + PADDING, MIN_HEIGHT)
    
    -- Calculate width based on longest item name
    local maxNameLength = 0
    for _, item in ipairs(keyItemStatuses) do
        if item.name and #item.name > maxNameLength then
            maxNameLength = #item.name
        end
    end
    
    local dynamicWidth = math.min(math.max(BASE_WIDTH + (maxNameLength * 6), MIN_WIDTH), MAX_WIDTH)
    
    return dynamicWidth, requiredHeight
end

-- Center text within current column
local function center_text(text)
    local col_start = imgui.GetColumnOffset()
    local col_width = imgui.GetColumnWidth()
    local text_width = imgui.CalcTextSize(text)
    local pos_x = col_start + (col_width - text_width) / 2
    imgui.SetCursorPosX(pos_x)
    imgui.Text(text)
end

-- Render column headers
local function render_headers(total_width)
    imgui.Columns(4, 'cooldownColumns', true)
    
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
end

-- Render time remaining with special canteen handling
local function render_time_remaining(item, hasItem, storageCanteens)
    local displayText
    local textColor = {1, 0.2, 0.2, 1} -- red default
    local showCanteenCount = (item.id == 3137)
    
    -- Check if we have a timestamp for this item
    local timestamp = item.timestamp or 0
    
    if timestamp == 0 then
        -- No timestamp recorded yet
        textColor = {0.7, 0.7, 0.7, 1} -- gray
        displayText = 'Unknown'
    elseif item.remaining <= 0 then
        textColor = {0, 1, 0, 1} -- green
        displayText = 'Available'
    else
        local rh = math.floor(item.remaining / 3600)
        local rm = math.floor((item.remaining % 3600) / 60)
        local rs = item.remaining % 60
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

    -- Tooltip
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        if timestamp == 0 then
            imgui.Text('No acquisition time recorded yet.')
            imgui.Text('Acquire the item to start tracking.')
        elseif item.remaining <= 0 then
            if item.id == 3137 and storageCanteens == 3 then
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

-- Render a single key item row
local function render_key_item_row(item, hasItem, cooldown, storageCanteens)
    -- Key Item Name (left aligned)
    imgui.Text(item.name)
    imgui.NextColumn()

    -- Have? (centered, colored)
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

    -- Time Remaining
    render_time_remaining(item, hasItem, storageCanteens)
    imgui.NextColumn()
    
    -- Add spacing between rows
    imgui.Spacing()
end

-- Main render function
function gui.render(keyItemStatuses, has_key_item_func, trackedKeyItems, storageCanteens)
    if not showGui[1] then return end

    -- Calculate dynamic window dimensions
    local width, height = calculate_window_dimensions(keyItemStatuses)
    imgui.SetNextWindowSizeConstraints({width, height}, {width, height})

    if not imgui.Begin('Key Item Cooldowns', showGui) then
        imgui.End()
        return
    end

    local total_width = imgui.GetWindowContentRegionWidth()
    
    -- Render headers
    render_headers(total_width)

    -- Render key item rows
    for i, item in ipairs(keyItemStatuses) do
        local hasItem = has_key_item_func(item.id)
        local cooldown = trackedKeyItems[item.id] or 0
        
        render_key_item_row(item, hasItem, cooldown, storageCanteens)
    end

    imgui.Columns(1)
    imgui.End()
end

return gui
