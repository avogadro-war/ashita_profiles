-- Constants for Keyring Addon
-- Centralizes all magic numbers and configuration values

local constants = {}

-- Key Item IDs
constants.KEY_ITEMS = {
    MOGLOPHONE = 3212,
    MYSTICAL_CANTEEN = 3137,
    SHINY_RAKAZNAR_PLATE = 3300,
}

-- Cooldown durations (in seconds)
constants.COOLDOWNS = {
    [3212] = 72000,  -- Moglophone: 20 hours
    [3137] = 72000,  -- Mystical Canteen: 20 hours
    [3300] = 72000,  -- Shiny Rakaznar Plate: 20 hours
}

-- Canteen-specific constants
constants.CANTEEN = {
    MAX_STORAGE = 3,
    COOLDOWN_SECONDS = 72000,  -- 20 hours
    CACHE_DURATION = 5,        -- Cache storage calculations for 5 seconds
}

-- GUI constants
constants.GUI = {
    HEADER_HEIGHT = 30,
    ITEM_HEIGHT = 22,
    SPACING_HEIGHT = 2,
    PADDING = 35,
    MIN_HEIGHT = 100,
    MIN_WIDTH = 450,
    MAX_WIDTH = 1200,
    BASE_WIDTH = 500,
    COLUMN_WIDTHS = {
        NAME_PERCENT = 0.45,
        STATUS_PERCENT = 0.15,
        COOLDOWN_PERCENT = 0.15,
        TIME_PERCENT = 0.25,
        MIN_NAME_WIDTH = 180,
        MIN_STATUS_WIDTH = 70,
        MIN_COOLDOWN_WIDTH = 70,
        MIN_TIME_WIDTH = 140,
    }
}

-- Timing constants
constants.TIMING = {
    STORAGE_UPDATE_INTERVAL = 5,  -- Update storage every 5 seconds
    ZONE_CHECK_DELAY = 6,         -- Delay before zone notifications
    LOAD_TIMEOUT = 10,            -- Timeout for player data loading
}

-- Packet IDs
constants.PACKETS = {
    KEY_ITEMS = 0x55,
    ZONE_COMPLETE = 0x0A,
    CURRENCY_REQUEST = 0x115,
    CURRENCY_RESPONSE = 0x118,
}

-- Colors (RGBA format)
constants.COLORS = {
    GREEN = {0, 1, 0, 1},           -- Available/Yes
    RED = {1, 0.2, 0.2, 1},         -- Unavailable/No
    GRAY = {0.7, 0.7, 0.7, 1},      -- Unknown
    WHITE = {1, 1, 1, 1},           -- Default text
}

-- File paths
constants.PATHS = {
    SETTINGS_FILE = 'data/keyring_settings.json',
}

-- Debug levels
constants.DEBUG = {
    NONE = 0,
    BASIC = 1,
    VERBOSE = 2,
}

return constants
