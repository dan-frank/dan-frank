{ pkgs }:

pkgs.writeShellApplication {
  name = "nb";
  runtimeInputs = [];
  text = ''
    nb() {
      if [ $# -eq 1 ]; then
        local systemName="$1"
          echo "Building system for: $systemName"
          nix build \
            --extra-experimental-features nix-command \
            --extra-experimental-features flakes \
          .#darwinConfigurations."$systemName".system
          ./result/sw/bin/darwin-rebuild switch --flake .#"$systemName"
      else
        echo "Usage: nb <system-name>"
      fi
    };
    nb "$@";
  '';
}
