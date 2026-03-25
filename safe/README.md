# Recovery Firmware

Known-good firmware builds for recovering a bricked or misbehaving Leeloo keyboard.

## Quick Recovery

```bash
just recover          # Flash both halves with known-good firmware
just recover-reset    # Clear BLE bonds first (if pairing issues)
```

## Firmware Files

| File | Zephyr | Description |
|------|--------|-------------|
| `seth_left.uf2` | 3.5.0 | **Recommended** - Joey's build for Seth (left half) |
| `seth_right.uf2` | 3.5.0 | **Recommended** - Joey's build for Seth (right half) |
| `leeloo_left.uf2` | 3.0.0 | Joey's older default build (left half) |
| `leeloo_right.uf2` | 3.0.0 | Joey's older default build (right half) |
| `settings_reset_final.uf2` | - | Clears BLE bonds and settings |
| `reset_zmk.uf2` | - | Alternative reset firmware |

## When to Use

**Use `just recover` if:**
- Keys register incorrectly (e.g., N types M, M types comma)
- Keyboard stops responding after flashing new firmware
- BLE pairing completely broken after firmware change

**Use `just recover-reset` first if:**
- Split halves won't communicate
- Keyboard won't pair with computer
- Switching between test firmware and recovery

## Source

Firmware provided by Joey @ [ClicketySplit](https://clicketysplit.ca).

Built from: `ClicketySplit/zmk` branch `chiisai_v1.13` (Zephyr 3.5.0+zmk-fixes)
Board: `nice_nano_v2` (Zephyr 3.5 naming convention)

## Keymap Files

| File | Description |
|------|-------------|
| `joeys_leeloo.keymap` | Joey's full keymap (Win + macOS layers, encoders) |
| `leeloo.keymap` | Old broken keymap (wrong row distribution - DO NOT USE) |
| `leeloo.orig.keymap` | Original keymap backup |

## Notes

The firmware in this directory uses the **old ZMK board naming** (`nice_nano_v2`).
Our current builds target Zephyr 4.1 which uses `nice_nano` (boards were restructured).

If building against Joey's fork for maximum compatibility:
- Clone: `https://github.com/ClicketySplit/zmk` branch `chiisai_v1.13`
- Use board: `-b nice_nano_v2` 
- Use keymap: `config/leeloo-3.5.keymap`
