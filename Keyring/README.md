# Keyring - Final Fantasy XI Key Item Cooldown Tracker

A Final Fantasy XI addon for Ashita4 that tracks key items with cooldown timers, providing real-time status updates and notifications.

## Features

- **Automatic Detection**: Automatically detects when key items are acquired via packet interception
- **Real-time Tracking**: Live countdown timers for key item cooldowns
- **Smart Notifications**: Zone change notifications for available items you don't currently have
- **Special Canteen Tracking**: Advanced tracking for Mystical Canteen with storage system (1/3, 2/3, 3/3)
- **Persistent State**: Remembers timestamps across game sessions
- **Modern GUI**: Clean, responsive interface with dynamic sizing
- **Unknown Status**: Shows "Unknown" for items that haven't been acquired yet

## Tracked Key Items

The addon currently tracks these key items with their respective cooldowns:

- **Moglophone** (20h cooldown)
- **Mystical Canteen** (20h cooldown) - with special storage tracking
- **Shiny Rakaznar Plate** (20h cooldown)

## Installation

1. Download the addon files
2. Place the `Keyring` folder in your Ashita4 `addons` directory:
   ```
   Ashita4/addons/Keyring/
   ```
3. Load the addon in-game with:
   ```
   /addon load keyring
   ```

## Commands

| Command | Description |
|---------|-------------|
| `/keyring` or `/keyring gui` | Toggle the GUI window |
| `/keyring debug` | Toggle debug messages in chat |
| `/keyring check` | Manually check for available key items |
| `/keyring notify` | Toggle zone change notifications |
| `/keyring help` | Show detailed help information |

## GUI Interface

The addon provides a clean, responsive GUI with four columns:

- **Key Item**: Name of the tracked item
- **Have?**: Whether you currently possess the item (Yes/No)
- **Cooldown**: The item's cooldown duration in hours
- **Time Remaining**: Current status with countdown timer

### Status Colors

- **Gray**: "Unknown" - No acquisition time recorded yet
- **Green**: "Available" - Item is off cooldown and can be acquired
- **Red**: Countdown timer - Shows remaining time until available
- **White**: Canteen storage count (e.g., "Available (2/3)")

## How It Works

### Automatic Detection
The addon intercepts network packets to detect when key items are acquired, automatically recording timestamps for accurate cooldown tracking.

### Zone Change Notifications
When you zone into a new area, the addon checks if any tracked key items are available for pickup (off cooldown and not currently in your inventory) and notifies you automatically.

### Special Canteen Handling
The Mystical Canteen has a unique storage system where you can hold up to 3 canteens. The addon tracks this storage count and displays it alongside the availability status.

### Persistent Storage
All timestamps and state information are saved between game sessions, ensuring your tracking continues even after logging out and back in.

## File Structure

```
Keyring/
├── keyring.lua                    # Main addon file with GUI and commands
├── keyring_packet_handler.lua     # Packet interception and state management
├── keyring_gui.lua               # GUI rendering module (new)
├── settings_manager.lua          # Settings management (new)
├── constants.lua                 # Constants and configuration (new)
├── key_items_optimized.lua       # Optimized key item mappings (new)
├── tracked_key_items.lua         # Configuration of tracked items
├── key_items.lua                 # Complete key item ID to name mappings
├── data/                         # Data directory for settings
└── README.md                     # This file
```

### Module Overview

- **`keyring.lua`**: Main addon entry point, command handling, and event registration
- **`keyring_packet_handler.lua`**: Network packet interception and state management
- **`keyring_gui.lua`**: ImGui rendering logic and window management
- **`settings_manager.lua`**: Unified settings loading/saving with fallback support
- **`constants.lua`**: Centralized constants and configuration values
- **`key_items_optimized.lua`**: Memory-efficient key item mappings (only tracked items)
- **`tracked_key_items.lua`**: Configuration of which items to track and their cooldowns

## Requirements

- Final Fantasy XI
- Ashita4 client
- Windows operating system

## Troubleshooting

### Settings Module Error
If you encounter a settings module error on first load, the addon will automatically fall back to internal storage. This is normal for fresh installations.

### Debug Mode
Enable debug mode with `/keyring debug` to see detailed packet information and troubleshooting messages.

### Manual State Reset
If tracking becomes inaccurate, you can reset the addon by:
1. Unloading the addon: `/addon unload keyring`
2. Deleting the `data/keyring_settings.json` file (if it exists)
3. Reloading the addon: `/addon load keyring`

## Contributing

Feel free to submit issues, feature requests, or pull requests to improve the addon.

## Credits

- **Author**: Avogadro
- **Assistance**: Thorny and Will
- **Special Thanks**: To the Ashita4 community for packet analysis and technical support

## License

This addon is provided as-is for the Final Fantasy XI community. Use at your own discretion.

## Performance & Optimization

The addon has been optimized for performance and maintainability:

- **Memory Efficiency**: Uses optimized key item mappings that only load tracked items
- **Caching**: Implements intelligent caching for storage calculations to reduce redundant computations
- **Modular Design**: Separated concerns into dedicated modules for better maintainability
- **Error Handling**: Comprehensive input validation and error handling throughout
- **Settings Management**: Unified settings system with proper fallback mechanisms

## Version History

- **v0.2**: Performance and code organization improvements
  - Modular architecture with separated GUI and settings management
  - Memory optimization with targeted key item mappings
  - Caching system for storage calculations
  - Enhanced error handling and input validation
  - Centralized constants and configuration
  - Improved documentation and code structure

- **v0.1**: Initial release with core tracking functionality
  - Basic key item cooldown tracking
  - GUI interface
  - Packet-based detection
  - Zone change notifications
  - Special canteen handling
  - Persistent state storage 