{ pkgs }:
let 
  figletFonts = pkgs.fetchFromGitHub {
    owner = "xero";
    repo = "figlet-fonts";
    rev = "master";
    sha256 = "HmO968OYH5yWwsDRp7HVfWvp48upUv+YwZxcMxBHNSw=";
  };
in pkgs.writeShellApplication {
  name = "nb";
  runtimeInputs = with pkgs; [ figlet lolcat ripgrep ];
  text = ''
    nb() {
      if [ $# -eq 1 ]; then
        local systemName="$1"

        figlet -f "${figletFonts}/ANSI Shadow.flf" "Building system: $systemName" | lolcat

        nix build \
          --extra-experimental-features nix-command \
          --extra-experimental-features flakes \
          .#darwinConfigurations."$systemName".system &> nix-build.log ||
          (rg error nix-build.log && false)

        ./result/sw/bin/darwin-rebuild switch --flake .#"$systemName"
      else
        echo "Usage: nb <system-name>"
      fi
    };
    nb "$@";
  '';
}
