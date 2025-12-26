# Bluetooth Guide for Leeloo

This guide covers Bluetooth pairing, profile management, and troubleshooting for your Leeloo split keyboard.

## Accessing Bluetooth Controls (Layer 3)

Layer 3 (Firmware layer) contains all Bluetooth controls. Activate it by:

1. **Encoder buttons**: Hold both encoder buttons (one on each half)
2. **Conditional layer**: Hold Space (L1) + F key (L2) simultaneously

## Bluetooth Profiles

ZMK supports **5 Bluetooth profiles** by default, allowing you to pair with up to 5 different devices. Each profile stores the pairing information for one host device.

### How Profiles Work

- When you select an empty profile, the keyboard advertises itself as connectable
- Pairing with a new device stores the bond information in the current profile
- The keyboard may show as "connected" to multiple hosts, but only the **active profile** receives keystrokes
- Profile selection persists across restarts and firmware flashes

## Your Current Bluetooth Bindings (Layer 3)

```
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │ BT0 │ BT1 │ BT2 │ BT3 │ BT4 │     │       │    │       │ BT0 │ BT1 │ BT2 │ BT3 │ BT4 │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │BOOT │RESET│     │     │     │     │       │    │       │ BLE │ USB │ TOG │     │RESET│BOOT │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │EP_ON│       │    │       │     │BT_PR│     │BT_NX│     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │EP_OF││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │     │     │     │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││     │├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│          ↑
                                      ╰───────╯    ╰───────╯       BT_CLR
```

### Key Bindings Reference

| Position | Left Half | Right Half |
|----------|-----------|------------|
| **Number Row** | BT_SEL 0-4 (profiles) | BT_SEL 0-4 (profiles) |
| **Top Row Left** | `&bootloader` (Tab pos) | `&out OUT_BLE` (Y pos) |
| **Top Row** | `&sys_reset` (Q pos) | `&out OUT_USB` (U pos) |
| **Top Row** | - | `&out OUT_TOG` (I pos) |
| **Top Row Right** | - | `&sys_reset` (P pos) |
| **Top Row Far Right** | - | `&bootloader` (\ pos) |
| **Home Row** | `&ext_power EP_ON` (G pos) | `&bt BT_PRV` (J pos) |
| **Home Row** | - | `&bt BT_NXT` (L pos) |
| **Bottom Row** | `&ext_power EP_OFF` (B pos) | - |
| **Thumb Cluster** | - | `&bt BT_CLR` (DEL pos) |

## Pairing a New Device

### Example: Pair to a New Mac

```
1. Hold down: Space (left thumb) + F (left index finger)
   → Layer 3 activates

2. While still holding Space+F, tap: 1 (or any unused profile number)
   → Selects Bluetooth profile 1

3. Release all keys

4. On your Mac: System Settings → Bluetooth
   → Find "Leeloo" in the device list

5. Click "Connect"
   → Pairing completes, keyboard is now usable
```

### Profile Number Keys (while holding Space+F)

| Key | Profile |
|-----|---------|
| `` ` `` (grave/tilde) | Profile 0 |
| `1` | Profile 1 |
| `2` | Profile 2 |
| `3` | Profile 3 |
| `4` | Profile 4 |

The right half has the same profiles on `6`, `7`, `8`, `9`, `0`.

### Example: Switch Between Paired Devices

Already paired to Mac (profile 0) and iPad (profile 1)? Here's how to switch:

```
1. Hold down: Space + F
   → Layer 3 activates

2. While holding, tap: 1
   → Switches to profile 1 (iPad)

3. Release all keys
   → Keyboard connects to iPad
```

To switch back to Mac:
```
1. Hold: Space + F
2. Tap: ` (grave key, top-left)
3. Release
```

### Cycling Through Profiles

Instead of memorizing profile numbers:

```
1. Hold: Space + F

2. Tap: J to go to previous profile
   OR
   Tap: L to go to next profile

3. Release when on desired profile
```

## Output Selection (USB vs Bluetooth)

When your keyboard is **both paired via Bluetooth AND plugged into USB**, ZMK needs to know
which computer should receive your keystrokes. By default, ZMK prefers USB when connected.

### Why Output Selection Matters

| Scenario | Problem | Solution |
|----------|---------|----------|
| Laptop paired via BT, plug USB into desktop for charging | Keystrokes go to desktop instead of laptop | Press `Y` to force Bluetooth |
| Want to use USB for lower latency gaming | Keyboard keeps using Bluetooth | Press `U` to force USB |
| Switching between docked (USB) and mobile (BT) use | Have to re-pair each time | Use `I` to toggle, or select explicitly |

### Output Selection Keys (Layer 3)

| Key | Binding | What It Does |
|-----|---------|--------------|
| `Y` | `&out OUT_BLE` | **Force Bluetooth** — ignores USB even if plugged in |
| `U` | `&out OUT_USB` | **Force USB** — ignores Bluetooth even if paired |
| `I` | `&out OUT_TOG` | **Toggle** — switches between BLE and USB |

### Example: Use Bluetooth While Charging via USB

```
1. Plug keyboard into USB (for charging)

2. Hold down: Space + F
   → Layer 3 activates

3. While holding, tap: Y
   → Forces Bluetooth output

4. Release all keys
   → Keystrokes now go over Bluetooth, USB only charges
```

### Example: Switch Back to USB Output

```
1. Hold: Space + F
2. Tap: U
3. Release
   → Keystrokes now go over USB
```

### Example: Toggle Between Outputs

```
1. Hold: Space + F
2. Tap: I
3. Release
   → Switches from current output to the other
   → Tap I again to switch back
```

### Default Behavior

- **USB plugged in**: ZMK automatically uses USB output
- **USB unplugged**: ZMK uses Bluetooth (if paired)
- **Both available**: USB takes priority unless you override with `Y`

Your output selection persists until you change it or unplug/disconnect.

## Troubleshooting

### Keyboard Not Appearing in Bluetooth List

1. Ensure you're on an unpaired profile (or clear the current one with `BT_CLR`)
2. Check that the keyboard has power (battery charged or USB connected)
3. Try restarting Bluetooth on your Mac

### macOS Shows Connected but Keys Don't Work

This is a common bonding issue:

1. Remove the keyboard from macOS: System Settings > Bluetooth > Right-click keyboard > Forget
2. Activate Layer 3 (encoder buttons or Space+F)
3. Make sure the problematic profile is selected (use number keys or BT_PRV/BT_NXT)
4. Press the **DEL key position on the right thumb cluster** (`&bt BT_CLR`)
5. Release Layer 3
6. Re-pair from scratch

### Split Halves Not Communicating

The left (central) and right (peripheral) halves pair automatically. If they stop working:

1. Flash the `settings_reset` firmware to **both** halves
2. Flash the normal firmware to both halves
3. Power cycle both halves at roughly the same time

See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for the full reset procedure.

### Weak or Unreliable Connection

Your config already has BLE power boost enabled:
```
CONFIG_BT_CTLR_TX_PWR_PLUS_8=y
```

If issues persist, try:
- Moving closer to the host device
- Avoiding metal enclosures
- Ensuring no interference from other 2.4GHz devices

## macOS-Specific Notes

### Battery Reporting Wake Issue

On macOS, BLE battery reporting packets can wake the computer from sleep. If this is a problem, you can disable battery reporting by adding to `leeloo.conf`:

```
CONFIG_BT_BAS=n
```

Note: This only disables reporting to the host; the keyboard can still show battery on its display (if equipped).

### Multiple Battery Levels (Split Keyboard)

macOS typically only shows the central (left) half's battery level. To see both:
- Use a third-party app like "Bluetooth Battery Monitor"
- Or enable peripheral battery fetching (requires additional config)

## Quick Reference Card

```
ACTIVATE LAYER 3:
  Hold both encoder buttons
  OR hold Space (left thumb) + F key together

PROFILE SELECTION (Layer 3):
  `, 1, 2, 3, 4  = Select profile 0-4 (left half)
  6, 7, 8, 9, 0  = Select profile 0-4 (right half)
  J              = Previous profile (BT_PRV)
  L              = Next profile (BT_NXT)

CLEAR PROFILE (Layer 3):
  Right thumb DEL position = Clear current profile (BT_CLR)

OUTPUT SELECTION (Layer 3):
  Y = Force Bluetooth output
  U = Force USB output
  I = Toggle USB/BLE

EXTERNAL POWER (Layer 3):
  G = External power ON
  B = External power OFF

PAIRING NEW DEVICE:
  1. Layer 3 + select empty profile (number key)
  2. Find "Leeloo" in host Bluetooth settings
  3. Connect/Pair
  4. Release Layer 3
```

## References

- [ZMK Bluetooth Docs](https://zmk.dev/docs/features/bluetooth)
- [ZMK Bluetooth Behaviors](https://zmk.dev/docs/keymaps/behaviors/bluetooth)
- [ZMK Connection Troubleshooting](https://zmk.dev/docs/troubleshooting/connection-issues)
