-- Settings Manager for Keyring Addon
-- Provides a unified interface for loading/saving settings with proper error handling

local chat = require('chat')

local settings_manager = {}

-- Default settings structure
local default_settings = {
    timestamps = {},
    owned = {},
    last_storage = 0,
    storage_canteens = 0,
    last_canteen_time = 0,
    debug_mode = false,
    notifications_enabled = true,
    gui_visible = false
}

local settings_file = 'data/keyring_settings.json'
local current_settings = {}

-- Try to load external settings module
local function load_external_settings()
    local success, external_settings = pcall(require, 'settings')
    if success and external_settings then
        print(chat.header('Keyring'):append(chat.message('External settings module loaded successfully.')))
        return external_settings
    end
    return nil
end

-- Load settings using JSON fallback
local function load_json_settings()
    local json_success, json = pcall(require, 'json')
    if not json_success or not json then
        print(chat.header('Keyring'):append(chat.message('Warning: JSON module not available. Using default settings.')))
        return nil
    end
    
    local file = io.open(settings_file, 'r')
    if not file then
        print(chat.header('Keyring'):append(chat.message('No settings file found. Using default settings.')))
        return nil
    end
    
    local content = file:read('*all')
    file:close()
    
    local success, data = pcall(json.decode, content)
    if not success or not data then
        print(chat.header('Keyring'):append(chat.message('Settings file corrupted. Using default settings.')))
        return nil
    end
    
    print(chat.header('Keyring'):append(chat.message('Settings loaded from JSON file.')))
    return data
end

-- Save settings using JSON
local function save_json_settings(data)
    local json_success, json = pcall(require, 'json')
    if not json_success or not json then
        print(chat.header('Keyring'):append(chat.message('Warning: JSON module not available. Settings will not persist.')))
        return false
    end
    
    -- Ensure directory exists
    local dir = string.match(settings_file, '(.+)/[^/]*$')
    if dir then
        os.execute('mkdir -p "' .. dir .. '"')
    end
    
    local file = io.open(settings_file, 'w')
    if not file then
        print(chat.header('Keyring'):append(chat.message('Error: Cannot write settings file.')))
        return false
    end
    
    file:write(json.encode(data))
    file:close()
    return true
end

-- Initialize settings manager
function settings_manager.init()
    -- Try external settings first
    local external_settings = load_external_settings()
    if external_settings then
        current_settings = external_settings.load(default_settings) or default_settings
        settings_manager.save = function(data) 
            external_settings.save(data)
            current_settings = data
        end
        return
    end
    
    -- Fallback to JSON
    local json_data = load_json_settings()
    if json_data then
        current_settings = json_data
    else
        current_settings = default_settings
    end
    
    settings_manager.save = function(data)
        if save_json_settings(data) then
            current_settings = data
        end
    end
end

-- Get a setting value
function settings_manager.get(key, default)
    return current_settings[key] or default
end

-- Set a setting value
function settings_manager.set(key, value)
    current_settings[key] = value
    settings_manager.save(current_settings)
end

-- Get all settings
function settings_manager.get_all()
    return current_settings
end

-- Reset to defaults
function settings_manager.reset()
    current_settings = default_settings
    settings_manager.save(current_settings)
    print(chat.header('Keyring'):append(chat.message('Settings reset to defaults.')))
end

-- Validate settings structure
function settings_manager.validate()
    local valid = true
    for key, default_value in pairs(default_settings) do
        if current_settings[key] == nil then
            current_settings[key] = default_value
            valid = false
        end
    end
    
    if not valid then
        print(chat.header('Keyring'):append(chat.message('Settings structure updated with missing defaults.')))
        settings_manager.save(current_settings)
    end
    
    return valid
end

return settings_manager
