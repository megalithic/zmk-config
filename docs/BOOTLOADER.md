# nice!nano bootloader and flashing

Use this procedure for the Leeloo v1.13 left and right nice!nano v2 controllers.

## Recommended method

Use each controller's hardware reset button. This identifies the physical half unambiguously.

A split peripheral sends key events to the central controller for processing. A keymap `&bootloader` binding therefore should not be used to assume a particular physical half will reboot.

## Before flashing

Install project tools and download a successful firmware build:

```sh
mise install
mise run download
mise run status
```

Or build a newly pushed configuration:

```sh
mise run build
```

## Back up and flash both halves

Start the guarded flasher:

```sh
mise run flash
```

The task first captures and validates `CURRENT.UF2` from each physical controller. It then supplies separate new files for:

- Central/left: `leeloo_left-*.uf2`
- Peripheral/right: `leeloo_right-*.uf2`

You will enter bootloader mode twice per half: once for the backup and once for the flash.

### Left half

1. Disconnect the right half from USB.
2. Connect the left half with a data-capable USB cable.
3. When `zmk-flasher` requests the central controller, press Enter.
4. Quickly double-tap the left nice!nano reset button.
5. Wait for the `NICENANO` volume to appear.
6. Confirm flashing in `zmk-flasher`.
7. Wait for the volume to disappear and the controller to reboot.

### Right half

1. Disconnect the left half from USB.
2. Connect the right half.
3. When `zmk-flasher` requests the peripheral controller, press Enter.
4. Quickly double-tap the right nice!nano reset button.
5. Wait for the `NICENANO` volume.
6. Confirm flashing.
7. Wait for reboot.

Flash both halves from the same GitHub Actions run.

## Restore the pre-flash firmware

If the new build is unusable, run:

```sh
mise run restore
```

The task verifies the recorded checksums and uses `zmk-flasher` to restore the left and right application-firmware readbacks captured immediately before the last flash. Connect only the requested physical half.

`CURRENT.UF2` is an application rollback image, not a complete hardware-programmer backup of the bootloader and all controller state. The old images under `safe/` are separate recovery artifacts and are not verified device backups.

## Manual fallback

If `zmk-flasher` fails:

1. Run `mise run status` to locate selected left and right UF2 files.
2. Connect one half.
3. Double-tap its reset button.
4. Copy the matching UF2 file to `/Volumes/NICENANO` in Finder.
5. Wait for the volume to disconnect.
6. Repeat with the other half and its matching file.

macOS may report an ejection or copy warning after the controller accepts firmware and reboots. Verify that the `NICENANO` volume disappeared before retrying.

## Reset-pin fallback

If the reset button is inaccessible, quickly short `RST` to `GND` twice. The controller should mount as `NICENANO`.

## Firmware-layer bindings

`config/leeloo.keymap` contains `&bootloader` and `&sys_reset` on Layer 3. Layer 3 activates while Space and F are held.

These bindings can reboot the active ZMK controller, but hardware reset remains the recommended flashing method because it selects the physical nice!nano directly.

## Troubleshooting

### `NICENANO` does not appear

- Use a data-capable cable.
- Avoid USB hubs.
- Double-tap reset more quickly.
- Disconnect the other half.
- Try another USB port.

### zmk-flasher detects the wrong disk

`zmk-flasher` watches for newly mounted user volumes. Disconnect unrelated removable drives before flashing and connect only the requested keyboard half.

### Controller stays in bootloader

- Single-tap reset once.
- Power-cycle the half.
- Enter bootloader again and reflash the matching UF2.

### Halves do not reconnect

- Confirm both files came from the same run.
- Power-cycle both halves.
- Reflash both halves.
- Use settings-reset firmware only if Bluetooth bond corruption is suspected; it erases saved pairings.

## References

- [nice!nano getting started](https://nicekeyboards.com/docs/nice-nano/getting-started)
- [ZMK user setup](https://zmk.dev/docs/user-setup)
- [`zmk-flasher`](https://github.com/new-er/zmk-flasher)
