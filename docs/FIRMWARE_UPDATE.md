# Firmware build and update guide

This repository builds firmware for a Leeloo PCB v1.13 with nice!nano v2 controllers.

## Build configuration

| Half | Board | Shield |
| --- | --- | --- |
| Left, central | `nice_nano//zmk` | `leeloo_left` |
| Right, peripheral | `nice_nano//zmk` | `leeloo_right` |

The board name matters:

- `nice_nano_v2` is the obsolete Zephyr 3.5 name.
- Bare `nice_nano` omits ZMK's required Zephyr 4.1 board variant.
- `nice_nano//zmk` selects nice!nano v2 with ZMK defaults.

The Leeloo v1.13 PCB uses the upstream `leeloo_left` and `leeloo_right` shields. Do not use newer `clickety_split_leeloo_*` shields.

## Install project tools

```sh
mise trust
mise install
gh auth login
```

`mise.toml` installs GitHub CLI, Python, Go, and `zmk-flasher` v0.0.4.

## Validate changes

```sh
mise run check
mise run status
```

Validation checks:

- Four layers with 58 bindings each
- Leeloo row shape
- Defined behaviors and valid layer references
- Current hold-tap property names
- `&sys_reset` rather than deprecated `&reset`
- Two `nice_nano//zmk` targets
- `leeloo_left` and `leeloo_right` shields

## Commit and push with Jujutsu

GitHub Actions can build only pushed files:

```sh
jj describe -m "fix: update Leeloo firmware configuration"
jj bookmark set master -r @
jj git push --bookmark master
jj new master
```

`jj new master` leaves an empty working-copy commit on the pushed `master`. `mise run build` refuses to run when local changes have not been pushed.

## Build and download firmware

```sh
mise run build
```

This task:

1. Validates active configuration.
2. Confirms local and GitHub `master` match.
3. Dispatches `.github/workflows/build.yml`.
4. Waits for both halves to build.
5. Downloads the `firmware` artifact.
6. Records the selected run in `build/firmware/.latest-run`.

Inspect recent runs with:

```sh
mise run runs
```

Download the latest successful firmware for current remote `master` without starting a new build:

```sh
mise run download
```

## Flash firmware

```sh
mise run flash
```

The task passes the left and right UF2 files to `zmk-flasher`. Follow its prompts and double-tap each physical controller's reset button when requested.

See [BOOTLOADER.md](BOOTLOADER.md) for exact steps.

## ZMK source pin

`config/west.yml` pins a tested ZMK commit instead of tracking moving `main`. This prevents upstream changes from breaking an unchanged keyboard configuration.

To update ZMK:

1. Find the desired commit in [zmkfirmware/zmk](https://github.com/zmkfirmware/zmk/commits/main).
2. Change `revision` in `config/west.yml`.
3. Run `mise run check`.
4. Commit and push.
5. Run `mise run build`.
6. Flash both halves and test before making unrelated keymap changes.

## GitHub Actions failures seen in this repository

### `nice_nano_v2` board not found

Cause: Zephyr 4.1 consolidated nice!nano revisions.

Fix: use `nice_nano//zmk` for nice!nano v2.

### Selected board is not set up for ZMK

Cause: bare `nice_nano` selects the stock Zephyr board while a ZMK variant exists.

Fix:

```yaml
board: nice_nano//zmk
```

### Deprecated reset behavior

Cause: older keymap used `&reset`.

Fix: use `&sys_reset`.

## Recovery firmware

Files under `safe/` and `support/` are old recovery artifacts. They are not normal build inputs and may not match current keymap or ZMK versions.

Settings-reset firmware erases Bluetooth bonds. Do not flash it during a routine keymap update.

## References

- [ZMK Zephyr 4.1 migration](https://zmk.dev/blog/2025/12/09/zephyr-4-1)
- [ZMK Leeloo shield](https://github.com/zmkfirmware/zmk/tree/main/app/boards/shields/leeloo)
- [Leeloo v1.0/v1.13 build guide](https://github.com/ClicketySplit/build-guides/blob/main/leeloo/README.md)
