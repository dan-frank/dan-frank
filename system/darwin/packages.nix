{ pkgs, ... }:
{
  programs.nix-index.enable = true;

  environment.systemPackages = with pkgs; [
    # _1password-gui
    qemu
    rectangle
    slack
    utm
  ];
}
