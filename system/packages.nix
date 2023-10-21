{ pkgs, ... }:
let
  hss-start-script = import ../scripts/hss-start.nix { inherit pkgs; };
  hss-stop-script = import ../scripts/hss-stop.nix { inherit pkgs; };
  nb-script = import ../scripts/nb.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    alacritty
    git
    vscode

    hss-start-script
    hss-stop-script
    nb-script
  ];
}
