# [Leeloo](https://clicketysplit.ca/pages/leeloo)

Personal ZMK configuration for the Leeloo split keyboard by Clickety Split, running on nice!nano controllers.

## Documentation

| Guide | Description |
|-------|-------------|
| [Bluetooth](docs/BLUETOOTH.md) | Pairing, profiles, and troubleshooting BLE connections |
| [Battery](docs/BATTERY.md) | Monitoring battery levels on macOS |
| [Bootloader](docs/BOOTLOADER.md) | Entering bootloader mode and flashing firmware |
| [Firmware Updates](docs/FIRMWARE_UPDATE.md) | Updating ZMK and Leeloo shield |
| [Homerow Mods](docs/HOMEROW_MODS.md) | Configuring homerow modifiers |

## Quick Reference

### Layer Activation

| Layer | Name | How to Activate |
|-------|------|-----------------|
| **L1** | LOWER | Hold **Space** (left thumb) |
| **L2** | RAISE | Hold **F** key |
| **L3** | FIRMWARE | Hold **both encoder buttons** OR hold **Space + F** together |

**Note:** Layer 3 activates via conditional layers when L1+L2 are both active (Space + F held simultaneously).

### Step-by-Step Examples

#### Example 1: Enter Bootloader Mode (Left Half)

To flash new firmware to the **left** half while connected via USB:

```
1. Hold down: Space (left thumb) + F (left index finger)
   → This activates Layer 3 (L1+L2 conditional)

2. While still holding Space+F, tap: TAB
   → Left half enters bootloader mode

3. Release all keys
   → "NICENANO" USB drive appears on your Mac

4. Drag firmware file to NICENANO drive
```

#### Example 2: Enter Bootloader Mode (Right Half)

To flash new firmware to the **right** half:

```
1. Hold down: Space (left thumb) + F (left index finger)
   → This activates Layer 3

2. While still holding Space+F, tap: \ (backslash, right pinky)
   → Right half enters bootloader mode

3. Release all keys
   → "NICENANO" USB drive appears on your Mac
```

#### Example 3: Pair Keyboard to New Bluetooth Device

To pair your Leeloo to a new Mac/iPad/phone:

```
1. Hold down: Space (left thumb) + F (left index finger)
   → This activates Layer 3

2. While still holding Space+F, tap: 2 (or any unused profile 1-4)
   → Selects Bluetooth profile 2

3. Release all keys

4. On your Mac: System Settings → Bluetooth → Find "Leeloo" → Connect
```

#### Example 4: Switch Between Paired Devices

To switch from your Mac (profile 0) to your iPad (profile 1):

```
1. Hold down: Space + F
   → Activates Layer 3

2. While holding, tap: 1
   → Switches to Bluetooth profile 1

3. Release all keys
   → Keyboard connects to device on profile 1
```

#### Example 5: Force Bluetooth Output While USB Connected

When charging via USB but want to type over Bluetooth:

```
1. Hold down: Space + F
   → Activates Layer 3

2. While holding, tap: Y
   → Forces Bluetooth output

3. Release all keys
   → Keystrokes now go over Bluetooth, not USB
```

### Bluetooth Pairing

1. Activate Layer 3 (see above)
2. Press a number key to select a profile (`` ` ``=0, `1`=1, `2`=2, `3`=3, `4`=4)
3. Find "Leeloo" in your device's Bluetooth settings
4. Connect and pair
5. Release Layer 3

### Entering Bootloader Mode

| Method | Steps |
|--------|-------|
| **Via keymap** | Layer 3 + `TAB` (left) or `\` (right) |
| **Hardware** | Double-tap the reset button on the nice!nano |

A USB drive named "NICENANO" will appear for flashing.

### Build/Flash

Builds and flashes ZMK firmware via Docker.

```sh
make build        # Build only [alias: make b]
make flash-left   # Build and flash left [alias: make l]
make flash-right  # Build and flash right [alias: make r]
make clean        # Clean cache for fresh rebuild
```

## Macros

| Macro | Keys | Description |
|-------|------|-------------|
| `SCRN` | Cmd+Shift+Ctrl+4 | Screenshot to clipboard |
| `SCR2` | Cmd+Shift+4 | Screenshot to file |
| `WLEFT` | Option+Left | Word left |
| `WRIGHT` | Option+Right | Word right |

### Layout

#### Layer 0: _`DEFAULT`_

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │  `~ │  1! │  2@ │  3# │  4$ │  5% │       │    │       │ 6^  │ 7&  │ 8*  │ 9(  │ 0)  │ -_  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │ TAB │  Q  │  W  │  E  │  R  │  T  │       │    │       │  Y  │  U  │  I  │  O  │  P  │ \|  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │ LC/⎋│  A  │  S  │  D  │ F/L2│  G  │       │    │       │  H  │  J  │  K  │  L  │ ;:  │ '"  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │ LSH │  Z  │  X  │  C  │  V  │  B  ││  L3 ││    ││ L3  ││  N  │  M  │ ,<  │ .>  │ /?  │ RSH │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │SP/L1│╭─────╮│    │╭─────╮│ SPC │ BSP │ DEL │
                    ╰─────┴─────┴─────┤│ F19 ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [LAYER ACTIVATION]
  SP/L1   Hold Space → Layer 1 (LOWER)
  F/L2    Hold F → Layer 2 (RAISE)
  L3      Encoder buttons, or Space+F together → Layer 3 (FIRMWARE)

  [HOLD-TAP KEYS]
  LC/⎋    Tap → Escape, Hold → Left Control
  SP/L1   Tap → Space, Hold → Layer 1
  F/L2    Tap → F, Hold → Layer 2
  BSP     Tap → Backspace, Ctrl+Tap → Delete

  [REFERENCE]
  ⌘   Command (or CMD/LGUI/LG)
  ⇧   Shift (or SH/LSH/RSH)
  ⌥   Option (or OPT/ALT/LA)
  ⌃   Control (or CTRL/LC)
  ⎋   Escape (or ESC)
```

<details>
<summary>Layer 1: <em><strong><code>LOWER</code></strong></em></summary>

**Activation:** Hold Space (left thumb, `&lt 1 SPACE`)

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │     │  F1 │  F2 │  F3 │  F4 │  F5 │       │    │       │ F6  │ F7  │ F8  │ F9  │ F10 │ =+  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │  W→ │     │     │     │       │    │       │     │     │     │ [{  │ ]}  │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │  ←  │  ↓  │  ↑  │  →  │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │  W← ││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │ SPC │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [MACROS]
  W→    LA(RIGHT)
  W←    LA(LEFT)

  [TAP DANCE]
  ~SCRSH td_SCRNSHT~

  [REFERENCE]
  ⌘     Command (or CMD/LGUI/LG)
  ⇧     Shift (or SH/LSH/RSH)
  ⌥     Option (or OPT/ALT/LA)
  ⌃     Control (or CTRL/LC)
  ⎋     Escape (or ESC)
```

</details>

<details>
<summary>Layer 3: <em><strong><code>FIRMWARE</code></strong></em> (Bluetooth, Bootloader, System)</summary>

**Activation:** Hold both encoder buttons OR hold Space+F together

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │ BT0 │ BT1 │ BT2 │ BT3 │ BT4 │     │       │    │       │ BT0 │ BT1 │ BT2 │ BT3 │ BT4 │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │BOOT │RESET│     │     │     │     │       │    │       │ BLE │ USB │ TOG │     │RESET│BOOT │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │EP_ON│       │    │       │     │BT_PR│     │BT_NX│     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │EP_OF││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │     │     │     │╭─────╮│    │╭─────╮│     │     │BT_CL│
                    ╰─────┴─────┴─────┤│     ││    ││     │├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯

  [BLUETOOTH]
  BT0-4     Select Bluetooth profile 0-4
  BT_PR     Previous Bluetooth profile
  BT_NX     Next Bluetooth profile
  BT_CL     Clear current profile pairing

  [OUTPUT]
  BLE       Force Bluetooth output
  USB       Force USB output
  TOG       Toggle USB/Bluetooth

  [SYSTEM]
  BOOT      Enter bootloader mode (for flashing)
  RESET     Soft reset (reboot controller)
  EP_ON     External power ON
  EP_OF     External power OFF
```

</details>

<details>
<summary>Layer 2: <em><strong><code>RAISE</code></strong></em></summary>

**Activation:** Hold F key (`&lt 2 F`)

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │     │  F1 │  F2 │  F3 │  F4 │  F5 │       │    │       │ F6  │ F7  │ F8  │ F9  │ F10 │ =+  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │  W→ │     │     │     │       │    │       │     │VOLM │VOL↓ │VOL↑ │NT/PR│PL/PA│
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │  ←  │  ↓  │  ↑  │  →  │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │  W← ││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │ SPC │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [MACROS]
  W→    LA(RIGHT)
  W←    LA(LEFT)

  [TAP DANCE]
  ~SCRSH td_SCRNSHT~
  NT/PR td_NEXT_PREV

  [REFERENCE]
  ⌘     Command (or CMD/LGUI/LG)
  ⇧     Shift (or SH/LSH/RSH)
  ⌥     Option (or OPT/ALT/LA)
  ⌃     Control (or CTRL/LC)
  ⎋     Escape (or ESC)
```
