# Bootloader Guide for nice!nano

This guide explains how to enter bootloader mode on your nice!nano controllers and flash new firmware.

## What is Bootloader Mode?

Bootloader mode allows you to flash new firmware to your nice!nano. When in bootloader mode, the controller appears as a USB storage device named **"NICENANO"** on your computer.

## Entering Bootloader Mode

### Method 1: Double-Tap Reset (Recommended for Hardware Issues)

The easiest way to enter bootloader mode when the keyboard is unresponsive:

1. **Double-tap the reset button** on your keyboard quickly (within ~500ms)
2. The nice!nano will enter bootloader mode
3. A USB drive named "NICENANO" will appear on your computer

### Method 2: Reset Pin Short

If your keyboard doesn't have a reset button:

1. Use tweezers or a wire to quickly short the **RST** and **GND** pins twice
2. Do this quickly (double-tap style)
3. The "NICENANO" drive should appear

### Method 3: Keymap Binding (Easiest When Keyboard Works)

Your keymap has `&bootloader` and `&sys_reset` on Layer 3 (Firmware layer).

**To activate Layer 3:**
- Hold both encoder buttons (one on each half), OR
- Hold Space (left thumb) + F key simultaneously

**Layer 3 Bootloader/Reset Layout:**
```
  ╭─────┬─────┬─────┬─────┬─────┬─────╮          ╭─────┬─────┬─────┬─────┬─────┬─────╮
  │     │     │     │     │     │     │          │     │     │     │     │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤          ├─────┼─────┼─────┼─────┼─────┼─────┤
  │BOOT │RESET│     │     │     │     │          │     │     │     │     │RESET│BOOT │
  ├─────┼─────┼─────┼─────┼─────┼─────┤          ├─────┼─────┼─────┼─────┼─────┼─────┤
  │ TAB │  Q  │     │     │     │     │          │     │     │     │     │  P  │  \  │
  └─────┴─────┴─────┴─────┴─────┴─────┘          └─────┴─────┴─────┴─────┴─────┴─────┘
```

**Key positions:**

| Key Position | Left Half | Right Half |
|--------------|-----------|------------|
| **Bootloader** | TAB position | Backslash `\` position |
| **Soft Reset** | Q position | P position |

**To enter bootloader on LEFT half:**
1. Activate Layer 3 (encoder buttons or Space+F)
2. Press the **TAB key** (top-left of alpha block)
3. The left nice!nano enters bootloader, "NICENANO" drive appears

**To enter bootloader on RIGHT half:**
1. Activate Layer 3 (encoder buttons or Space+F)
2. Press the **Backslash `\` key** (top-right of alpha block)
3. The right nice!nano enters bootloader, "NICENANO" drive appears

### Method 4: Soft Reset (sys_reset)

Soft reset reboots the controller without entering bootloader mode. Useful for applying config changes:

1. Activate Layer 3 (encoder buttons or Space+F)
2. Press **Q** (left half) or **P** (right half)
3. That half will reset and reconnect

## Flashing Firmware

### Step-by-Step Flashing

1. **Enter bootloader mode** using one of the methods above
2. **Locate the NICENANO drive** that appears on your Mac (check Finder sidebar or `/Volumes/NICENANO`)
3. **Copy the .uf2 file** to the drive:
   ```bash
   cp build/leeloo_left-nice_nano-zmk.uf2 /Volumes/NICENANO/
   ```
   Or simply drag and drop the file in Finder
4. **Wait for the drive to disconnect** - this happens automatically when flashing completes
5. **Repeat for the other half** if you're updating both sides

### Using the Makefile

The Makefile provides convenient commands:

```bash
# Build firmware only
make build

# Build and flash left half
make flash-left   # or: make l

# Build and flash right half
make flash-right  # or: make r

# Clean build artifacts
make clean
```

**Note**: The flash commands will wait for you to put the keyboard in bootloader mode.

## Important Notes

### Which Half to Flash

- **Left half (central)**: Handles keymap processing and Bluetooth host connections
- **Right half (peripheral)**: Sends key events to the left half

For **keymap changes only**, you typically only need to flash the left half. For **config changes** or **firmware updates**, flash both.

### Firmware Files

After building, firmware files are in the `build/` directory:
- `leeloo_left-nice_nano-zmk.uf2` - Left half firmware
- `leeloo_right-nice_nano-zmk.uf2` - Right half firmware

### Settings Reset Firmware

If you need to clear all stored settings (Bluetooth bonds, etc.), flash the `settings_reset` firmware first, then flash your normal firmware. See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md).

## Bootloader Troubleshooting

### NICENANO Drive Doesn't Appear

1. **Try a different USB cable** - some cables are charge-only
2. **Try a different USB port** - avoid USB hubs initially
3. **Check if the controller is damaged** - look for visible damage or burnt components
4. **Try the other half** - if one works, you know the cable/port is fine

### Drive Appears but Flashing Fails

1. **Wait for the copy to complete** - don't eject manually
2. **Check file size** - .uf2 files should be ~200-500KB
3. **Try copying via terminal** instead of Finder:
   ```bash
   cp firmware.uf2 /Volumes/NICENANO/ && sync
   ```

### Keyboard Unresponsive After Flash

1. **Power cycle** - unplug USB and remove battery briefly
2. **Re-flash** - enter bootloader and try again
3. **Flash settings_reset** - then flash normal firmware

## Step-by-Step Examples

### Flash the Left Half

```
1. Connect LEFT half to Mac via USB

2. Hold down: Space (left thumb) + F (left index)
   → Layer 3 activates

3. While still holding Space+F, tap: TAB
   → Left half enters bootloader

4. Release all keys
   → "NICENANO" drive appears in Finder

5. Drag .uf2 file to NICENANO
   → Drive auto-ejects when done
```

### Flash the Right Half

```
1. Connect RIGHT half to Mac via USB

2. Hold down: Space (left thumb) + F (left index)
   → Layer 3 activates

3. While still holding Space+F, tap: \ (backslash)
   → Right half enters bootloader

4. Release all keys
   → "NICENANO" drive appears in Finder

5. Drag .uf2 file to NICENANO
```

### Alternative: Hardware Reset

If the keyboard is unresponsive or you can't use the keymap:

```
1. Locate the reset button on the nice!nano
2. Double-tap it quickly (within 500ms)
3. "NICENANO" drive appears
```

## Quick Reference

```
ACTIVATE LAYER 3:
  Hold Space (left thumb) + F (left index) together

ENTER BOOTLOADER (while holding Space+F):
  Left half:  Tap TAB
  Right half: Tap \ (backslash)

SOFT RESET (while holding Space+F):
  Left half:  Tap Q
  Right half: Tap P

ENTER BOOTLOADER (Hardware):
  Double-tap reset button on nice!nano

FLASH FIRMWARE:
  1. Enter bootloader (NICENANO drive appears)
  2. Copy .uf2 file to NICENANO drive
  3. Wait for drive to disconnect
  4. Repeat for other half if needed

BUILD COMMANDS:
  make build        # Build both halves
  make flash-left   # Build + flash left (make l)
  make flash-right  # Build + flash right (make r)
```

## References

- [nice!nano Getting Started](https://nicekeyboards.com/docs/nice-nano/getting-started)
- [Adafruit nRF52 Bootloader](https://github.com/adafruit/Adafruit_nRF52_Bootloader)
- [ZMK Flashing Guide](https://zmk.dev/docs/user-setup)
