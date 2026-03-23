{
  description = "ZMK firmware build environment for Leeloo keyboard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Task runner
          just

          # Docker runtime
          colima
          docker-client
          docker-compose
          docker-buildx
        ];

        shellHook = ''
          echo ""
          echo "⌨️  ZMK firmware dev shell (Leeloo)"
          echo ""

          # Auto-start colima if docker isn't running
          if ! docker info &>/dev/null 2>&1; then
            echo "  Starting colima..."
            colima start --cpu 2 --memory 4 &>/dev/null

            if docker info &>/dev/null 2>&1; then
              echo "  ✓ Docker is running"
            else
              echo "  ✗ Failed to start colima. Run 'colima start' manually."
            fi
          else
            echo "  ✓ Docker is running"
          fi

          echo ""
          echo "  just build       — build both halves"
          echo "  just build-left  — build left only"
          echo "  just left        — build + flash left"
          echo "  just all         — build + flash both"
          echo ""
        '';
      };
    };
}
