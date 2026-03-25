{
  description = "ZMK firmware build environment for Leeloo keyboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};

      # Python with west for Zephyr builds
      pythonWithWest = pkgs.python3.withPackages (ps: [
        ps.west
        ps.pyelftools
        ps.pyyaml
      ]);
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Task runner
          just

          # ZMK CLI setup (uv installs zmk CLI)
          uv
          gh  # GitHub CLI for auth

          # West + Python (Zephyr meta tool)
          pythonWithWest

          # Build tools
          cmake
          ninja
          ccache
          gperf
          dtc  # Device tree compiler

          # ARM toolchain
          gcc-arm-embedded

          # Flashing tools
          dfu-util

          # Other dependencies
          git
          wget

          # Docker runtime (fallback)
          colima
          docker-client
          docker-compose
          docker-buildx
        ];

        env = {
          # Point to the ARM toolchain
          ZEPHYR_TOOLCHAIN_VARIANT = "gnuarmemb";
          GNUARMEMB_TOOLCHAIN_PATH = "${pkgs.gcc-arm-embedded}";
        };

        shellHook = ''
          echo ""
          echo "⌨️  ZMK firmware dev shell (Leeloo)"
          echo ""

          # Check if zmk CLI is installed
          if command -v zmk &>/dev/null; then
            echo "  ✓ zmk CLI: $(zmk --version 2>/dev/null)"
          else
            echo "  ⚠ zmk CLI not installed. Run: uv tool install zmk"
          fi

          echo ""
          echo "  Toolchain versions:"
          echo "    west: $(west --version 2>/dev/null || echo 'run west init first')"
          echo "    cmake: $(cmake --version | head -1 | cut -d' ' -f3)"
          echo "    arm-none-eabi-gcc: $(arm-none-eabi-gcc --version | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')"
          echo ""
          echo "  ZMK CLI setup (GitHub Actions builds):"
          echo "    uv tool install zmk      — install zmk CLI"
          echo "    gh auth login            — authenticate with GitHub"
          echo "    zmk init                 — create/clone config repo"
          echo "    zmk keyboard add         — add keyboard to build"
          echo "    zmk download             — download built firmware"
          echo ""
          echo "  Native build (west):"
          echo "    west init -l config/     — initialize workspace"
          echo "    west update              — fetch Zephyr + modules"
          echo "    west build -s zmk/app -b <board>"
          echo "    west flash               — flash connected board"
          echo ""
          echo "  Docker build (just):"
          echo "    just build       — build both halves"
          echo "    just left        — build + flash left"
          echo ""
        '';
      };
    };
}
