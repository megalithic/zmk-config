# Leeloo ZMK configuration

ZMK configuration for a Clickety Split Leeloo PCB v1.13 with two nice!nano v2 controllers.

## Hardware and build targets

| Role | ZMK shield | Board |
| --- | --- | --- |
| Left, central | `leeloo_left` | `nice_nano//zmk` |
| Right, peripheral | `leeloo_right` | `nice_nano//zmk` |

Leeloo v1.13 uses the upstream `leeloo_left` and `leeloo_right` shields. The `clickety_split_leeloo_*` shields are for newer Leeloo revisions and are not used here.

`config/west.yml` pins the ZMK source revision. `build.yaml` defines the two GitHub Actions builds.

## Setup

Install [mise](https://mise.jdx.dev/), then trust and install this project's tools:

```sh
mise trust
mise install
```

This installs:

- Go
- GitHub CLI
- Python
- [`zmk-flasher`](https://github.com/new-er/zmk-flasher) v0.0.4

Authenticate GitHub CLI once:

```sh
gh auth login
```

## Mise tasks

```sh
mise tasks          # List project tasks
mise run check      # Validate keymap and build targets
mise run status     # Show timing, build, and firmware status
mise run runs       # List recent GitHub firmware builds
mise run build      # Build remote master and download firmware
mise run download   # Download latest successful master firmware
mise run flash      # Flash both halves with zmk-flasher
```

`mise run build` uses GitHub Actions. It does not compile uncommitted local files. Commit and push the configuration first.

With Jujutsu:

```sh
jj describe -m "fix: update Leeloo firmware configuration"
jj bookmark set master -r @
jj git push --bookmark master
jj new master
mise run build
```

The final `jj new master` creates an empty working-copy commit. The build task rejects a working copy with uncommitted changes so GitHub cannot accidentally build older configuration.

Downloaded firmware is stored under `build/firmware/<run-id>/`. The selected run is recorded in `build/firmware/.latest-run`.

## Flash both halves

Run:

```sh
mise run flash
```

`zmk-flasher` prompts for the central/left half and peripheral/right half in sequence.

For each prompt:

1. Connect only the requested half over USB.
2. Quickly double-tap that half's nice!nano reset button.
3. Wait for the `NICENANO` volume.
4. Confirm the flash in `zmk-flasher`.
5. Wait for the controller to reboot before connecting the other half.

The task passes separate left and right UF2 files explicitly. Do not use one half's file on the other half.

Hardware reset is the reliable way to enter each controller's bootloader. Split key events are normally processed by the left central controller, so firmware-layer bootloader bindings should not be used to identify which physical controller will reboot.

See [docs/BOOTLOADER.md](docs/BOOTLOADER.md) for recovery details.

## Active configuration

| File | Purpose |
| --- | --- |
| `config/leeloo.keymap` | Active layers and behaviors |
| `config/leeloo.conf` | ZMK Kconfig options |
| `config/west.yml` | Pinned ZMK source revision |
| `build.yaml` | GitHub Actions board/shield matrix |
| `.github/workflows/build.yml` | Reusable ZMK build workflow |
| `mise.toml` | Project tools and common tasks |
| `scripts/firmware` | Build, download, and flash automation |
| `scripts/validate-keymap` | Static Leeloo keymap validation |

Files under `safe/` and `support/` are recovery artifacts. They are not inputs to normal builds.

## Left home-row mods

Only the left home row uses home-row modifiers:

| Key | Tap | Hold |
| --- | --- | --- |
| A | A | Left Command/GUI |
| S | S | Left Shift |
| D | D | Left Option/Alt |

Current left-side behavior:

```dts
flavor = "balanced";
tapping-term-ms = <350>;
quick-tap-ms = <200>;
require-prior-idle-ms = <200>;
hold-trigger-on-release;
```

Only opposite-hand positions trigger an early hold. The longer 350 ms tapping term and 200 ms prior-idle window favor taps and reduce accidental Command activation on A.

If cross-hand rolls still produce Command shortcuts, change only `hml` to `flavor = "tap-preferred";`. That prevents interruption from resolving a hold early, but deliberate Command chords then require holding A past the tapping term.

See [docs/HOMEROW_MODS.md](docs/HOMEROW_MODS.md) for tuning details.

## Layers

| Layer | Activation | Purpose |
| --- | --- | --- |
| 0, QWERTY | Default | Typing and left home-row mods |
| 1, Lower | Hold Space | Navigation and symbols |
| 2, Raise | Hold F | Navigation and media |
| 3, Firmware | Hold Space and F | Bluetooth, output, reset, bootloader |

The firmware layer contains `&bootloader` and `&sys_reset`, but hardware reset is recommended when flashing a specific physical half.

## Troubleshooting

### GitHub build says board has a ZMK variant

`build.yaml` must use:

```yaml
board: nice_nano//zmk
```

`nice_nano_v2` is an obsolete Zephyr 3.5 board name. Bare `nice_nano` selects the stock Zephyr board instead of ZMK's board variant.

### `NICENANO` does not appear

- Use a data-capable USB cable.
- Connect the half directly rather than through a hub.
- Double-tap reset faster.
- Disconnect the other half while flashing.

### Halves do not communicate

- Flash both halves from the same GitHub Actions run.
- Power-cycle both halves.
- Use settings-reset firmware only when Bluetooth bonds must be erased.

## References

- [Leeloo v1.0/v1.13 build guide](https://github.com/ClicketySplit/build-guides/blob/main/leeloo/README.md)
- [ZMK Leeloo shield](https://github.com/zmkfirmware/zmk/tree/main/app/boards/shields/leeloo)
- [ZMK hold-tap behavior](https://zmk.dev/docs/keymaps/behaviors/hold-tap)
- [ZMK Zephyr 4.1 migration](https://zmk.dev/blog/2025/12/09/zephyr-4-1)
- [`zmk-flasher`](https://github.com/new-er/zmk-flasher)
