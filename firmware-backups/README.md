# Device firmware backups

`mise run flash` saves each controller's `CURRENT.UF2` here before it flashes new firmware. These files stay local because device readbacks may contain controller settings such as Bluetooth bonds.

- `.latest-backup` points to the most recent verified two-half backup.
- `.rollback-backup` points to the backup captured immediately before the last flash.
- `mise run restore` verifies checksums and restores that rollback pair.

A device readback is an application rollback image. It is not a complete hardware-programmer backup of the bootloader and all controller state.

Files under [`safe/`](../safe/) are old recovery images supplied by ClicketySplit. They are not verified backups of the physical controllers.
