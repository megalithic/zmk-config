# Battery Status Guide

This guide covers how to monitor battery levels on your Leeloo keyboard.

## Battery Reporting Overview

ZMK automatically reports battery levels over Bluetooth to connected host devices. The nice!nano uses its built-in battery sensing capabilities to monitor the connected LiPo battery.

## Viewing Battery on macOS

### System Bluetooth Menu

1. Click the Bluetooth icon in the menu bar
2. Hover over your keyboard name
3. Battery percentage should appear (if supported by your macOS version)

### System Settings

1. Open **System Settings** > **Bluetooth**
2. Find your keyboard in the list
3. Battery level may be shown next to the device name

### Third-Party Apps

For more detailed battery information, consider:

- **[Bluetooth Battery Monitor](https://github.com/msh2481/BluetoothBatteryMonitor)** - Free, shows all BLE device batteries
- **Juice** - Menu bar app for battery levels
- **coconutBattery** - Comprehensive battery monitoring

## Split Keyboard Battery Levels

For split keyboards like the Leeloo:

- **Only the central (left) half** reports battery to the host by default
- The peripheral (right) half's battery is not visible to macOS without additional configuration

### Enabling Peripheral Battery Monitoring

To see both halves' battery levels, add these to your `leeloo.conf`:

```ini
# Enable peripheral battery level fetching
CONFIG_ZMK_SPLIT_BLE_CENTRAL_BATTERY_LEVEL_FETCHING=y

# Enable peripheral battery level proxy (reporting to host)
CONFIG_ZMK_SPLIT_BLE_CENTRAL_BATTERY_LEVEL_PROXY=y
```

**Note**: Host support for multiple battery levels varies. You may need a third-party app to see both.

## Battery Configuration Options

Add these to `config/leeloo.conf`:

```ini
# Battery reporting is enabled by default with BLE
# CONFIG_ZMK_BATTERY_REPORTING=y  # (default: enabled with BLE)

# Battery level report interval in seconds (default: 60)
CONFIG_ZMK_BATTERY_REPORT_INTERVAL=60

# Disable battery reporting to host (keeps local display working)
# Useful if battery packets wake your Mac from sleep
# CONFIG_BT_BAS=n
```

## macOS Sleep Wake Issue

macOS may wake from sleep when receiving BLE battery updates. To prevent this:

```ini
# In leeloo.conf
CONFIG_BT_BAS=n
```

This disables battery *reporting* to the host but keeps battery *monitoring* working for displays.

## Battery Level on OLED Display

If your Leeloo has an OLED display, battery level can be shown there. Enable the display:

```ini
# In leeloo.conf
CONFIG_ZMK_DISPLAY=y
```

**Note**: ZMK's display support is still in development. There's a known issue where displays may remain blank after power resume ([GitHub #674](https://github.com/zmkfirmware/zmk/issues/674)).

## Battery Life Tips

### Power Consumption by Role

| Role | Power Usage | Notes |
|------|-------------|-------|
| Central (left) | Higher | Must wake periodically to check for peripheral data |
| Peripheral (right) | Lower | Only transmits when keys pressed |

### Extending Battery Life

1. **Enable deep sleep** (if not using display):
   ```ini
   CONFIG_ZMK_SLEEP=y
   CONFIG_ZMK_IDLE_SLEEP_TIMEOUT=600000  # 10 minutes in ms
   ```

2. **Disable RGB/Backlight** (if equipped):
   - RGB and backlight LEDs consume significant power
   - Not recommended for wireless builds

3. **Use the power switch** on Leeloo v2:
   - The Alps Alpine switch completely cuts power
   - Prevents any battery drain when not in use

4. **Check the ZMK Power Profiler**:
   - Visit [zmk.dev/power-profiler](https://zmk.dev/power-profiler)
   - Input your battery capacity and usage patterns
   - Get estimated battery life

## Low Battery Behavior

When battery is critically low:
- The keyboard may disconnect intermittently
- Some features may behave erratically
- Charge as soon as possible to avoid deep discharge

## Quick Reference

```
VIEW BATTERY:
  macOS: Bluetooth menu or System Settings
  Third-party: Bluetooth Battery Monitor app
  On keyboard: OLED display (if equipped)

COMMON CONFIG OPTIONS:
  CONFIG_ZMK_BATTERY_REPORT_INTERVAL=60    # Report every 60s
  CONFIG_BT_BAS=n                          # Disable host reporting
  CONFIG_ZMK_SPLIT_BLE_CENTRAL_BATTERY_LEVEL_FETCHING=y  # Fetch peripheral battery
  CONFIG_ZMK_SPLIT_BLE_CENTRAL_BATTERY_LEVEL_PROXY=y     # Report both to host
```

## References

- [ZMK Battery Feature](https://zmk.dev/docs/features/battery)
- [ZMK Battery Configuration](https://zmk.dev/docs/config/battery)
- [ZMK Power Profiler](https://zmk.dev/power-profiler)
- [ZMK Low Power States](https://zmk.dev/docs/features/low-power-states)
