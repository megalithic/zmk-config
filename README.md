# Leeloo ZMK Configuration

Personal ZMK configuration for the [Leeloo](https://clicketysplit.ca/pages/leeloo) split keyboard by Clickety Split, running on nice!nano v2 controllers.

## Table of Contents

- [Quick Start](#quick-start)
- [Layers & Layout](#layers--layout)
- [Flashing Firmware](#flashing-firmware)
- [Bluetooth Setup](#bluetooth-setup)
- [Building Firmware](#building-firmware)
- [Homerow Mods](#homerow-mods)
- [Troubleshooting](#troubleshooting)
- [Additional Documentation](#additional-documentation)

---

## Quick Start

### Build & Flash (Docker)

```bash
just build        # Build both halves
just flash-left   # Flash left half (waits for bootloader)
just flash-right  # Flash right half
just all          # Build and flash both
```

### Enter Bootloader Mode

| Method | Steps |
|--------|-------|
| **Left half** | Hold **Space + F** → tap **TAB** |
| **Right half** | Hold **Space + F** → tap **\ (backslash)** |
| **Hardware** | Double-tap reset button on nice!nano |

### Switch Bluetooth Devices

Hold **Space + F** → tap **1-4** to switch profiles

---

## Layers & Layout

### Layer Overview

| Layer | Name | Activation |
|-------|------|------------|
| **0** | DEFAULT | Base layer |
| **1** | LOWER | Hold **Space** (left thumb) |
| **2** | RAISE | Hold **F** key |
| **3** | FIRMWARE | Hold **Space + F** together (conditional) |

### Layer 0: DEFAULT

Base QWERTY layer with homerow mods.

```
┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
│  `~  │  1!  │  2@  │  3#  │  4$  │  5%  │                │  6^  │  7&  │  8*  │  9(  │  0)  │  -_  │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│ TAB  │  Q   │  W   │  E   │  R   │  T   │                │  Y   │  U   │  I   │  O   │  P   │  \|  │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│CTL/⎋ │  A   │  S   │  D   │ F/L2 │  G   │                │  H   │  J   │  K   │  L   │  ;:  │  '"  │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│ LSFT │  Z   │  X   │  C   │  V   │  B   │  L3  │  │  L3  │  N   │  M   │  ,<  │  .>  │  /?  │ RSFT │
└──────┴──────┴──────┼──────┼──────┼──────┼──────┤  ├──────┼──────┼──────┼──────┼──────┴──────┴──────┘
                     │ OPT  │ CMD  │SPC/L1│ F19  │  │ENTER │ SPC  │ BSPC │ DEL  │
                     └──────┴──────┴──────┴──────┘  └──────┴──────┴──────┴──────┘
```

**Hold-Tap Keys:**
- `CTL/⎋` — Tap: Escape, Hold: Left Control
- `SPC/L1` — Tap: Space, Hold: Layer 1 (LOWER)
- `F/L2` — Tap: F, Hold: Layer 2 (RAISE)
- `BSPC` — Tap: Backspace, Ctrl+Tap: Delete

**Homerow Mods (GACS):**
- Left hand: A=GUI, S=ALT, D=CTRL
- Right hand: J=SHIFT, K=CTRL, L=ALT, ;=GUI

### Layer 1: LOWER

**Activation:** Hold Space (left thumb)

```
┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
│      │  F1  │  F2  │  F3  │  F4  │  F5  │                │  F6  │  F7  │  F8  │  F9  │ F10  │  =+  │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │  W→  │      │      │      │                │      │      │      │  [{  │  ]}  │      │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │      │                │  ←   │  ↓   │  ↑   │  →   │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │  W←  │      │  │      │      │      │      │      │      │      │
└──────┴──────┴──────┼──────┼──────┼──────┼──────┤  ├──────┼──────┼──────┼──────┼──────┴──────┴──────┘
                     │      │      │██████│      │  │      │      │      │      │
                     └──────┴──────┴──────┴──────┘  └──────┴──────┴──────┴──────┘
```

- `W→` — Option+Right (word right)
- `W←` — Option+Left (word left)
- Arrow keys on right hand home row

### Layer 2: RAISE

**Activation:** Hold F key

```
┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
│      │  F1  │  F2  │  F3  │  F4  │  F5  │                │  F6  │  F7  │  F8  │  F9  │ F10  │  =+  │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │  W→  │      │      │      │                │      │ MUTE │ VOL↓ │ VOL↑ │ ⏭/⏮ │ ⏯   │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │██████│      │                │  ←   │  ↓   │  ↑   │  →   │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │  W←  │      │  │      │      │      │      │      │      │      │
└──────┴──────┴──────┼──────┼──────┼──────┼──────┤  ├──────┼──────┼──────┼──────┼──────┴──────┴──────┘
                     │      │      │      │      │  │      │      │      │      │
                     └──────┴──────┴──────┴──────┘  └──────┴──────┴──────┴──────┘
```

- Media controls on right side
- `⏭/⏮` — Tap: Next track, Double-tap: Previous track

### Layer 3: FIRMWARE

**Activation:** Hold Space + F together (conditional layer: L1 + L2)

```
┌──────┬──────┬──────┬──────┬──────┬──────┐                ┌──────┬──────┬──────┬──────┬──────┬──────┐
│ BT 0 │ BT 1 │ BT 2 │ BT 3 │ BT 4 │      │                │ BT 0 │ BT 1 │ BT 2 │ BT 3 │ BT 4 │      │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│ BOOT │RESET │      │      │      │      │                │ BLE  │ USB  │ TOG  │      │RESET │ BOOT │
├──────┼──────┼──────┼──────┼──────┼──────┤                ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │██████│EP ON │                │      │ BT ← │      │ BT → │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┼──────┐  ┌──────┼──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │      │EP OFF│      │  │      │      │      │      │      │      │      │
└──────┴──────┴──────┼──────┼──────┼──────┼──────┤  ├──────┼──────┼──────┼──────┼──────┴──────┴──────┘
                     │      │      │██████│      │  │      │      │      │BT CLR│
                     └──────┴──────┴──────┴──────┘  └──────┴──────┴──────┴──────┘
```

**Bootloader & Reset:**
| Key | Position | Function |
|-----|----------|----------|
| `BOOT` | Top-left (TAB) | Enter bootloader (LEFT half) |
| `BOOT` | Top-right (\\) | Enter bootloader (RIGHT half) |
| `RESET` | Second from left (Q) | Soft reset LEFT half |
| `RESET` | Second from right (P) | Soft reset RIGHT half |

**Bluetooth:**
| Key | Function |
|-----|----------|
| `BT 0-4` | Select Bluetooth profile |
| `BT ←/→` | Previous/Next profile |
| `BT CLR` | Clear current profile pairing |

**Output:**
| Key | Function |
|-----|----------|
| `BLE` | Force Bluetooth output |
| `USB` | Force USB output |
| `TOG` | Toggle between USB/Bluetooth |

**Power:**
| Key | Function |
|-----|----------|
| `EP ON` | External power ON |
| `EP OFF` | External power OFF |

---

## Flashing Firmware

### Method 1: Keymap (Keyboard Working)

**Flash LEFT half:**
```
1. Hold Space (left thumb) + F (left index)
   → Layer 3 activates

2. While holding, tap TAB (top-left key)
   → Left half enters bootloader

3. /Volumes/NICENANO appears on Mac

4. Copy firmware:
   cp build/leeloo_left-nice_nano-zmk.uf2 /Volumes/NICENANO/
```

**Flash RIGHT half:**
```
1. Hold Space (left thumb) + F (left index)
   → Layer 3 activates

2. While holding, tap \ (backslash, top-right key)
   → Right half enters bootloader

3. /Volumes/NICENANO appears on Mac

4. Copy firmware:
   cp build/leeloo_right-nice_nano-zmk.uf2 /Volumes/NICENANO/
```

### Method 2: Hardware Reset (Keyboard Unresponsive)

1. Locate the reset button on the nice!nano controller
2. Double-tap the reset button quickly (within 500ms)
3. `/Volumes/NICENANO` appears
4. Copy the .uf2 file to the drive

### Method 3: Reset Pin Short

If no reset button is accessible:
1. Use tweezers to short **RST** and **GND** pins twice quickly
2. `/Volumes/NICENANO` appears

### Bootloader Key Positions

```
LAYER 3 (hold Space + F):

LEFT HALF                                    RIGHT HALF
┌──────┬──────┬─────────────────┐            ┌─────────────────┬──────┬──────┐
│ BOOT │RESET │                 │            │                 │RESET │ BOOT │
│ (TAB)│  (Q) │      ...        │            │      ...        │  (P) │  (\) │
└──────┴──────┴─────────────────┘            └─────────────────┴──────┴──────┘
   ↑                                                                     ↑
   │                                                                     │
   └── Tap here for LEFT bootloader              Tap here for RIGHT ─────┘
```

### Which Half to Flash?

| Change Type | Flash |
|-------------|-------|
| Keymap only | Left half only (central) |
| Config changes | Both halves |
| Firmware update | Both halves |

---

## Bluetooth Setup

### Pairing a New Device

1. **Activate Layer 3:** Hold Space + F
2. **Select profile:** Tap a number key (` = 0, 1-4 = profiles 1-4)
3. **Release keys**
4. **On your device:** Go to Bluetooth settings → Find "Leeloo" → Connect

### Switching Between Devices

```
1. Hold Space + F
2. Tap the profile number (1, 2, 3, or 4)
3. Release — keyboard connects to that device
```

### Profile Management

| Action | Keys (in Layer 3) |
|--------|-------------------|
| Select profile 0 | ` (grave) |
| Select profile 1-4 | 1, 2, 3, 4 |
| Previous profile | J |
| Next profile | L |
| Clear current profile | DEL (right thumb) |

### Force Output Mode

When connected via USB but want to type over Bluetooth:

```
1. Hold Space + F
2. Tap Y (BLE) to force Bluetooth
   — or tap U (USB) to force USB
   — or tap I (TOG) to toggle
3. Release
```

### Bluetooth Tips

- **Profile 0** is selected by the grave/tilde key (`)
- **Clear a profile** before re-pairing to a new device
- **Both halves** share Bluetooth profiles (only flash left for BT changes)
- See [docs/BLUETOOTH.md](docs/BLUETOOTH.md) for troubleshooting

---

## Building Firmware

### Using Just (Recommended)

```bash
# Build
just build          # Build both halves
just build-left     # Build left only
just build-right    # Build right only

# Flash (waits for bootloader)
just flash-left     # Flash left half
just flash-right    # Flash right half
just flash-both     # Flash both sequentially

# Combined
just left           # Build + flash left
just right          # Build + flash right
just all            # Build + flash both

# Utilities
just clean          # Remove .uf2 files
just clean-all      # Remove everything + docker image
just list           # Show built firmware files

# Settings reset (clears Bluetooth bonds)
just build-reset    # Build reset firmware
just flash-reset    # Flash reset to both halves
```

### Using Make (Legacy)

```bash
make build        # Build both halves
make flash-left   # Build + flash left (alias: make l)
make flash-right  # Build + flash right (alias: make r)
make clean        # Clean for fresh rebuild
```

### Requirements

- **Docker** — via colima on macOS
- **Just** — task runner (`brew install just` or via nix)

```bash
# Start Docker (if using colima)
colima start

# Or use nix-shell
nix-shell -p colima --run "colima start"
```

### GitHub Actions

Firmware is also built automatically on push. Download artifacts from the Actions tab.

---

## Homerow Mods

This config uses "timeless" homerow mods with bilateral trigger.

**Left hand (hold for modifier):**
- A → GUI (Command)
- S → ALT (Option)
- D → CTRL

**Right hand (hold for modifier):**
- J → SHIFT
- K → CTRL
- L → ALT (Option)
- ; → GUI (Command)

**Settings:**
- Tapping term: 280ms
- Quick tap: 175ms
- Require prior idle: 150ms

See [docs/HOMEROW_MODS.md](docs/HOMEROW_MODS.md) for tuning.

---

## Troubleshooting

### NICENANO Drive Doesn't Appear

1. Try a different USB cable (some are charge-only)
2. Try a different USB port
3. Double-tap reset faster (within 500ms)
4. Check if controller is damaged

### Keyboard Not Typing

1. Check Bluetooth connection on your device
2. Try toggling output: Layer 3 → Y (BLE) or U (USB)
3. Soft reset: Layer 3 → Q (left) or P (right)
4. Re-flash firmware

### Bluetooth Won't Pair

1. Clear the profile: Layer 3 → DEL
2. Remove device from your computer's Bluetooth settings
3. Re-pair

### Split Halves Not Communicating

1. Ensure both halves have matching firmware versions
2. Flash both halves with latest firmware
3. Try settings reset: `just flash-reset` then `just flash-both`

---

## Additional Documentation

| Guide | Description |
|-------|-------------|
| [Bluetooth](docs/BLUETOOTH.md) | Pairing, profiles, troubleshooting |
| [Battery](docs/BATTERY.md) | Monitoring battery on macOS |
| [Bootloader](docs/BOOTLOADER.md) | Detailed flashing guide |
| [Firmware Updates](docs/FIRMWARE_UPDATE.md) | Updating ZMK |
| [Homerow Mods](docs/HOMEROW_MODS.md) | Tuning hold-tap behavior |

---

## Macros Reference

| Macro | Keys | Description |
|-------|------|-------------|
| `SCRN` | Cmd+Shift+Ctrl+4 | Screenshot to clipboard |
| `SCR2` | Cmd+Shift+4 | Screenshot to file |
| `WLEFT` | Option+Left | Word left |
| `WRIGHT` | Option+Right | Word right |

---

## Symbol Reference

| Symbol | Meaning |
|--------|---------|
| ⌘ | Command (GUI) |
| ⌥ | Option (ALT) |
| ⌃ | Control (CTRL) |
| ⇧ | Shift |
| ⎋ | Escape |
| ← ↓ ↑ → | Arrow keys |
| ⏯ | Play/Pause |
| ⏭ ⏮ | Next/Previous track |
