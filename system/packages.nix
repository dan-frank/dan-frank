{ pkgs, ... }:
let
  aj-start-script = import ../scripts/aj-start.nix { inherit pkgs; };
  aj-stop-script = import ../scripts/aj-stop.nix { inherit pkgs; };
  nb-script = import ../scripts/nb.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    alacritty
    git
    vscode

    aj-start-script
    aj-stop-script
    nb-script
  ];
}
