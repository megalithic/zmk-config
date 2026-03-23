# ZMK Firmware Build & Flash
# Usage: just <recipe>

# Configuration
board := "nice_nano"
shield_left := "leeloo_left"
shield_right := "leeloo_right"
docker_image := "zmkfirmware/zmk-build-arm:stable"
volume_name := "NICENANO"

# Output paths
build_dir := "build"
cache_dir := ".cache"
file_left := build_dir / shield_left + "-" + board + "-zmk.uf2"
file_right := build_dir / shield_right + "-" + board + "-zmk.uf2"

# Default recipe - show help
default:
    @just --list

# Check if Docker is running, start colima if needed
[private]
docker-check:
    #!/usr/bin/env bash
    set -euo pipefail
    if docker info &>/dev/null; then
        echo "✓ Docker is running"
    else
        echo "Docker not running. Starting colima..."
        if command -v colima &>/dev/null; then
            colima start
        else
            echo "ERROR: Docker not running and colima not found."
            echo "Enter the dev shell first: nix develop"
            exit 1
        fi
    fi

# ─────────────────────────────────────────────────────────────────────────────
# Build Recipes
# ─────────────────────────────────────────────────────────────────────────────

# Build both halves
build: docker-check _build-both
    @echo ""
    @echo "✓ Build complete!"
    @ls -la {{build_dir}}/*.uf2 2>/dev/null || true

# Build left half only
build-left: docker-check _build-left
    @echo ""
    @echo "✓ Left half built: {{file_left}}"

# Build right half only  
build-right: docker-check _build-right
    @echo ""
    @echo "✓ Right half built: {{file_right}}"

[private]
_build-both:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{build_dir}} {{cache_dir}}
    
    docker run --rm \
        -v "$(pwd)/{{cache_dir}}:/keeb" \
        -v "$(pwd)/config:/keeb/config:ro" \
        -v "$(pwd)/{{build_dir}}:/build" \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        {{docker_image}} sh -c '
            cd /keeb
            [ ! -d .west ] && west init -l config
            [ ! -d zmk ] && west update
            west zephyr-export
            
            echo "══════════════════════════════════════════════════════════════"
            echo "Building LEFT half: {{shield_left}}"
            echo "══════════════════════════════════════════════════════════════"
            west build --pristine -b {{board}} zmk/app -- \
                -DSHIELD={{shield_left}} \
                -DZMK_CONFIG=/keeb/config
            cp build/zephyr/zmk.uf2 /build/{{shield_left}}-{{board}}-zmk.uf2
            
            echo ""
            echo "══════════════════════════════════════════════════════════════"
            echo "Building RIGHT half: {{shield_right}}"
            echo "══════════════════════════════════════════════════════════════"
            west build --pristine -b {{board}} zmk/app -- \
                -DSHIELD={{shield_right}} \
                -DZMK_CONFIG=/keeb/config
            cp build/zephyr/zmk.uf2 /build/{{shield_right}}-{{board}}-zmk.uf2
            
            chown $UID:$GID /build/*.uf2
        '

[private]
_build-left:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{build_dir}} {{cache_dir}}
    
    docker run --rm \
        -v "$(pwd)/{{cache_dir}}:/keeb" \
        -v "$(pwd)/config:/keeb/config:ro" \
        -v "$(pwd)/{{build_dir}}:/build" \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        {{docker_image}} sh -c '
            cd /keeb
            [ ! -d .west ] && west init -l config
            [ ! -d zmk ] && west update
            west zephyr-export
            
            echo "Building LEFT half: {{shield_left}}"
            west build --pristine -b {{board}} zmk/app -- \
                -DSHIELD={{shield_left}} \
                -DZMK_CONFIG=/keeb/config
            cp build/zephyr/zmk.uf2 /build/{{shield_left}}-{{board}}-zmk.uf2
            chown $UID:$GID /build/*.uf2
        '

[private]
_build-right:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{build_dir}} {{cache_dir}}
    
    docker run --rm \
        -v "$(pwd)/{{cache_dir}}:/keeb" \
        -v "$(pwd)/config:/keeb/config:ro" \
        -v "$(pwd)/{{build_dir}}:/build" \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        {{docker_image}} sh -c '
            cd /keeb
            [ ! -d .west ] && west init -l config
            [ ! -d zmk ] && west update
            west zephyr-export
            
            echo "Building RIGHT half: {{shield_right}}"
            west build --pristine -b {{board}} zmk/app -- \
                -DSHIELD={{shield_right}} \
                -DZMK_CONFIG=/keeb/config
            cp build/zephyr/zmk.uf2 /build/{{shield_right}}-{{board}}-zmk.uf2
            chown $UID:$GID /build/*.uf2
        '

# ─────────────────────────────────────────────────────────────────────────────
# Flash Recipes
# ─────────────────────────────────────────────────────────────────────────────

# Flash left half (waits for bootloader). Optional: just flash-left path/to/firmware.uf2
flash-left file=file_left: (_flash file "LEFT")

# Flash right half (waits for bootloader). Optional: just flash-right path/to/firmware.uf2
flash-right file=file_right: (_flash file "RIGHT")

# Flash both halves sequentially
flash-both: (flash-left) (flash-right)

# Build and flash left half
left: build-left flash-left

# Build and flash right half  
right: build-right flash-right

# Build and flash both halves
all: build flash-both

[private]
_flash file label:
    #!/usr/bin/env bash
    set -euo pipefail
    
    file="{{file}}"
    label="{{label}}"
    
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Firmware not found: $file"
        echo "Run 'just build' first."
        exit 1
    fi
    
    # Get file size (compatible with both GNU and BSD stat)
    fsize=$(wc -c < "$file" | awk '{printf "%.1f KB", $1/1024}')
    
    echo ""
    echo "══════════════════════════════════════════════════════════════"
    echo "  FLASH $label HALF"
    echo "══════════════════════════════════════════════════════════════"
    echo ""
    echo "  Firmware: $file ($fsize)"
    echo ""
    echo "  To enter bootloader mode:"
    echo "    • Double-tap the RESET button, OR"
    echo "    • Hold F + Space (layers 1+2), then tap top-${label,,} key"
    echo ""
    echo -n "  Waiting for NICENANO"
    
    # Wait for NICENANO volume via diskutil (more reliable than checking /Volumes)
    timeout=60
    elapsed=0
    dev=""
    while [[ -z "$dev" ]]; do
        dev=$(diskutil list 2>/dev/null | grep "NICENANO" | awk '{print $NF}' || true)
        if [[ -n "$dev" ]]; then
            break
        fi
        sleep 1
        elapsed=$((elapsed + 1))
        if [[ $elapsed -ge $timeout ]]; then
            echo ""
            echo "ERROR: Timeout waiting for NICENANO (${timeout}s)"
            exit 1
        fi
        echo -n "."
    done
    echo " ✓ ($dev)"
    
    sleep 0.5
    
    echo -n "  Unmounting..."
    diskutil unmount "$dev" 2>/dev/null || true
    echo " ✓"
    
    echo -n "  Writing firmware to /dev/$dev..."
    # Write UF2 directly to raw block device — macOS cp fails on UF2 volumes
    # with I/O or xattr errors. dd to the block device works reliably.
    sudo dd if="$file" of="/dev/$dev" bs=512 2>/dev/null
    echo " ✓"
    
    echo -n "  Waiting for reboot"
    sleep 2
    reboot_timeout=15
    reboot_elapsed=0
    while diskutil list 2>/dev/null | grep -q "NICENANO"; do
        sleep 1
        reboot_elapsed=$((reboot_elapsed + 1))
        if [[ $reboot_elapsed -ge $reboot_timeout ]]; then
            echo " ⚠ (device still in bootloader after ${reboot_timeout}s)"
            break
        fi
        echo -n "."
    done
    [[ $reboot_elapsed -lt $reboot_timeout ]] && echo " ✓"
    
    # Verify firmware booted
    echo -n "  Verifying firmware..."
    sleep 3
    if system_profiler SPUSBDataType 2>/dev/null | grep -q "ZMK Project"; then
        echo " ✓ (ZMK running)"
    elif system_profiler SPUSBDataType 2>/dev/null | grep -q "Nice Keyboards"; then
        echo " ⚠ Still in bootloader — single-tap reset to boot"
    else
        echo " ⚠ Not found on USB (ok if peripheral or on battery)"
    fi
    
    echo ""
    echo "  ✓ $label half flashed!"
    echo ""

# ─────────────────────────────────────────────────────────────────────────────
# Utility Recipes
# ─────────────────────────────────────────────────────────────────────────────

# Clean build artifacts
clean:
    rm -rf {{build_dir}}/*.uf2

# Clean everything (including cached ZMK source)
clean-all:
    rm -rf {{build_dir}} {{cache_dir}}
    docker image rm {{docker_image}} 2>/dev/null || true

# Show current firmware files
list:
    @echo "Build outputs:"
    @ls -la {{build_dir}}/*.uf2 2>/dev/null || echo "  (none - run 'just build')"

# Build settings reset firmware (for clearing bluetooth bonds)
build-reset: docker-check
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{build_dir}} {{cache_dir}}
    
    docker run --rm \
        -v "$(pwd)/{{cache_dir}}:/keeb" \
        -v "$(pwd)/config:/keeb/config:ro" \
        -v "$(pwd)/{{build_dir}}:/build" \
        -e UID=$(id -u) \
        -e GID=$(id -g) \
        {{docker_image}} sh -c '
            cd /keeb
            [ ! -d .west ] && west init -l config
            [ ! -d zmk ] && west update
            west zephyr-export
            
            echo "Building SETTINGS RESET firmware"
            west build --pristine -b {{board}} zmk/app -- \
                -DSHIELD=settings_reset \
                -DZMK_CONFIG=/keeb/config
            cp build/zephyr/zmk.uf2 /build/settings_reset-{{board}}-zmk.uf2
            chown $UID:$GID /build/*.uf2
        '
    @echo ""
    @echo "✓ Settings reset firmware built: {{build_dir}}/settings_reset-{{board}}-zmk.uf2"
    @echo "  Flash this to BOTH halves to clear bluetooth bonds"

# Flash settings reset firmware
flash-reset:
    #!/usr/bin/env bash
    set -euo pipefail
    
    file="{{build_dir}}/settings_reset-{{board}}-zmk.uf2"
    volume="/Volumes/{{volume_name}}"
    
    if [[ ! -f "$file" ]]; then
        echo "ERROR: Reset firmware not found. Run 'just build-reset' first."
        exit 1
    fi
    
    for side in LEFT RIGHT; do
        echo ""
        echo "══════════════════════════════════════════════════════════════"
        echo "  FLASH SETTINGS RESET - $side HALF"
        echo "══════════════════════════════════════════════════════════════"
        echo ""
        echo "  Enter bootloader mode on $side half..."
        echo -n "  Waiting for $volume"
        
        while [[ ! -d "$volume" ]]; do
            sleep 0.5
            echo -n "."
        done
        echo " ✓"
        
        sleep 0.5
        echo -n "  Copying reset firmware..."
        cp "$file" "$volume/"
        echo " ✓"
        
        while [[ -d "$volume" ]]; do
            sleep 0.3
        done
        echo "  ✓ $side half reset!"
        
        if [[ "$side" == "LEFT" ]]; then
            echo ""
            echo "  Now do the RIGHT half..."
            sleep 1
        fi
    done
    
    echo ""
    echo "✓ Both halves reset! Now flash your regular firmware with 'just flash-both'"
