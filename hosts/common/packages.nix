{ pkgs, ... }:
let
  nb-script = import ./../../scripts/nb.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    alacritty
    git
    vscode

    # === Scripts ===
    nb-script
  ];
}
