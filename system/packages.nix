{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # _1password-gui
    alacritty
    git
    rectangle
    slack
    utm
    vscode
  ];
}

