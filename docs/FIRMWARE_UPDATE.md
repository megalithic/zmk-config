# Firmware Update Guide

This guide explains how to update your Leeloo keyboard firmware, including getting the latest ZMK updates and Clickety Split Leeloo shield definitions.

## Firmware Architecture

Your ZMK firmware has two main components:

1. **ZMK Core** - The main firmware framework from [zmkfirmware/zmk](https://github.com/zmkfirmware/zmk)
2. **Leeloo Shield** - Board definitions from ZMK's official repository (contributed by Clickety Split)

Your personal config (keymaps, behaviors) sits on top of these.

## Updating ZMK Core

### Via west.yml (Recommended)

Your `config/west.yml` controls which ZMK version is used:

```yaml
manifest:
  remotes:
    - name: zmkfirmware
      url-base: https://github.com/zmkfirmware
  projects:
    - name: zmk
      remote: zmkfirmware
      revision: main  # <-- This determines the version
      import: app/west.yml
  self:
    path: config
```

**To update**: The `revision: main` means you're always getting the latest. Just rebuild your firmware:

```bash
make clean  # Clear cache to force fresh download
make build
```

### Pinning to a Specific Version

For stability, you can pin to a specific commit or tag:

```yaml
revision: v0.3.0  # Use a release tag
# or
revision: abc123def  # Use a specific commit hash
```

## Leeloo Shield Updates

The Leeloo shield is included in ZMK's main repository:
- [zmk/app/boards/shields/leeloo](https://github.com/zmkfirmware/zmk/tree/main/app/boards/shields/leeloo)

When you update ZMK (by rebuilding with `revision: main`), you automatically get the latest Leeloo shield.

### Checking for Leeloo Updates

1. Visit the [Leeloo shield directory](https://github.com/zmkfirmware/zmk/tree/main/app/boards/shields/leeloo)
2. Check the commit history for recent changes
3. Rebuild if updates exist

## Using Clickety Split's Config as Reference

Clickety Split maintains reference configurations:

- **ZMK Official**: [zmkfirmware/zmk/.../shields/leeloo](https://github.com/zmkfirmware/zmk/tree/main/app/boards/shields/leeloo)
- **Clickety Split GitHub**: [github.com/ClicketySplit](https://github.com/ClicketySplit)
- **Build Guides**: [ClicketySplit/build-guides](https://github.com/ClicketySplit/build-guides)

### Leeloo Versions

| Version | Shield | Notes |
|---------|--------|-------|
| Leeloo v1 | `leeloo_left`/`leeloo_right` | Original design |
| Leeloo v2 | `leeloo_left`/`leeloo_right` | Redesigned PCB, same shields |
| Leeloo v2.1 | `clickety_split_leeloo` | Power domain support, RGB LEDs |
| Leeloo-Micro v1.1 | `clickety_split_leeloo_micro` | Compact version with power domains |

## Power Domain Branch (Leeloo v2.1 / Leeloo-Micro v1.1)

If you have **Leeloo v2.1** or **Leeloo-Micro v1.1** with RGB LEDs, you should use Clickety Split's
power domain branch for proper power management. This prevents battery drain when the keyboard
is in sleep mode.

### Why Use the Power Domain Branch?

The main ZMK branch supports RGB LEDs and nice!view displays, but:
- Requires the bypass solderable jumper
- Battery capacity drains very quickly
- Power leaks during sleep mode

The power domain branch fixes these issues by completely cutting power to RGB LEDs during sleep.

### Switching to Power Domain Branch

**Option 1: Update west.yml for Local Builds**

```yaml
manifest:
  remotes:
    - name: zmkfirmware
      url-base: https://github.com/zmkfirmware
    - name: clicketysplit
      url-base: https://github.com/ClicketySplit
  projects:
    - name: zmk
      remote: clicketysplit
      revision: clickety_split_series_zmk_v3.5_power_domains
      import: app/west.yml
  self:
    path: config
```

**Option 2: GitHub Actions with Power Domain Branch**

Create/update `.github/workflows/build.yml`:

```yaml
on:
  push:
    paths:
      - "config/**"
  pull_request:
    paths:
      - "config/**"
  workflow_dispatch:

jobs:
  build:
    uses: ClicketySplit/zmk/.github/workflows/build-user-config.yml@clickety_split_series_zmk_v3.5_power_domains
```

### Update build.yaml for v2.1 Shields

If using the power domain branch, update your `build.yaml`:

```yaml
include:
  - board: nice_nano_v2
    shield: clickety_split_leeloo_left
  - board: nice_nano_v2
    shield: clickety_split_leeloo_right
```

### Power Domain Branch Links

- **Leeloo v2.1**: [ClicketySplit/zmk/clickety_split_leeloo](https://github.com/ClicketySplit/zmk/tree/clickety_split_series_zmk_v3.5_power_domains/app/boards/shields/clickety_split_leeloo)
- **Leeloo-Micro v1.1**: [ClicketySplit/zmk/clickety_split_leeloo_micro](https://github.com/ClicketySplit/zmk/tree/clickety_split_series_zmk_v3.5_power_domains/app/boards/shields/clickety_split_leeloo_micro)

## Build Methods

### Method 1: GitHub Actions (Easiest)

If you forked the zmk-config template:

1. Push changes to your GitHub repo
2. GitHub Actions automatically builds firmware
3. Download the artifacts from the Actions tab

Your `build.yaml` controls what gets built:

```yaml
include:
  - board: nice_nano
    shield: leeloo_left
  - board: nice_nano
    shield: leeloo_right
```

### Method 2: Local Docker Build (This Repo)

This repo uses Docker for local builds:

```bash
# Build both halves
make build

# Build and flash left
make flash-left  # or: make l

# Build and flash right
make flash-right  # or: make r

# Clean everything (forces fresh ZMK download)
make clean
```

### Method 3: Local Toolchain

For frequent development, install the ZMK toolchain locally:
- [ZMK Local Toolchain Setup](https://zmk.dev/docs/development/local-toolchain/setup)

## Updating Your Keymap

Your keymap lives in `config/leeloo.keymap`. To apply keymap changes:

1. Edit `config/leeloo.keymap`
2. Rebuild: `make build`
3. Flash the **left half only** (keymap runs on central): `make l`

**Note**: For config changes in `leeloo.conf`, flash both halves.

## Version Compatibility Notes

### nice_nano vs nice_nano_v2

Your `build.yaml` uses `nice_nano` but the Makefile uses `nice_nano_v2`. These are essentially interchangeable for the Leeloo, but you should be consistent:

```yaml
# build.yaml - for GitHub Actions
- board: nice_nano_v2
  shield: leeloo_left
```

```makefile
# Makefile - for local builds
board = nice_nano_v2
```

### Bootloader Compatibility

The nice!nano uses the Adafruit nRF52 bootloader. ZMK firmware is fully compatible - just drag and drop the `.uf2` file.

## Troubleshooting Updates

### Build Fails After Update

```bash
# Clear all cached data
make clean

# If still failing, manually remove cache
rm -rf .cache build/*.uf2

# Rebuild
make build
```

### New Features Not Working

1. Ensure you're using `revision: main` in west.yml
2. Clean and rebuild
3. Flash **both** halves (not just central)

### Reverting to Previous Version

Find a working commit hash from [ZMK commits](https://github.com/zmkfirmware/zmk/commits/main):

```yaml
# In config/west.yml
revision: abc123def456  # Replace with actual commit hash
```

Then rebuild.

## Changelog and Release Notes

- [ZMK Blog](https://zmk.dev/blog) - Major announcements
- [ZMK Changelog](https://github.com/zmkfirmware/zmk/commits/main) - All changes
- [ZMK Releases](https://github.com/zmkfirmware/zmk/releases) - Tagged releases

## Flashing the Firmware

### nice!nano / Elite-Pi (UF2 Method)

1. Connect the left or right half to USB-C
2. Double-click the reset button to enter bootloader mode
   - The keyboard will mount as a USB drive
3. Drag and drop the `.uf2` file to the drive root
4. Repeat for the other half

**Important**: Keep track of which nice!nano is left vs right — they need different firmware files!

### Elite-C (QMK Flash Method)

1. Connect the half to USB-C
2. Double-click reset to enter bootloader
3. Run `qmk flash` command
4. Repeat for other half (same `.hex` works for both sides)

## Determining Your Leeloo Version

Not sure which Leeloo you have?

| Feature | Leeloo v1 | Leeloo v2 | Leeloo v2.1 |
|---------|-----------|-----------|-------------|
| Power switch location | Less accessible | More accessible | Most accessible |
| nice!view support | Via wiring | Built-in | Built-in + power domain |
| RGB LED support | No | Yes (limited) | Yes (proper power mgmt) |
| Battery pads | Basic | Improved | Through-hole pads |

If you have RGB LEDs and want good battery life, you likely need Leeloo v2.1 with the power domain branch.

## Quick Reference

```
UPDATE ZMK (main branch):
  make clean && make build

UPDATE ZMK (power domain branch):
  1. Edit config/west.yml to use ClicketySplit remote
  2. make clean && make build

PIN VERSION:
  Edit config/west.yml, set revision: <tag or commit>

BUILD LOCALLY:
  make build        # Both halves
  make flash-left   # Build + flash left
  make flash-right  # Build + flash right

GITHUB ACTIONS:
  Push to repo, download artifacts from Actions tab

ENTER BOOTLOADER:
  Double-click reset button (keyboard mounts as USB drive)
```

## References

- [ZMK User Setup](https://zmk.dev/docs/user-setup)
- [ZMK Customization](https://zmk.dev/docs/customization)
- [Leeloo on Clickety Split](https://clicketysplit.ca/pages/leeloo)
- [ZMK GitHub](https://github.com/zmkfirmware/zmk)
