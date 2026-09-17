.DEFAULT_GOAL := help

.PHONY: help check status runs build download flash flash-both \
	build-left build-right flash-left flash-right

help:
	@mise tasks

check:
	@mise run check

status:
	@mise run status

runs:
	@mise run runs

build download flash:
	@mise run "$@"

flash-both: flash

build-left build-right:
	@echo "GitHub Actions builds both halves together."
	@mise run build

flash-left flash-right:
	@echo "Single-half legacy targets were removed to prevent flashing the wrong UF2."
	@echo "Use 'mise run flash' to flash both halves with explicit left/right files."
	@exit 1
