{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;
  programs.java.enable = true; # <- HSS

  home.packages = with pkgs; [
    # CLI Tools
    bottom
    htop

    # UI Tools
    # utm

    # Fun
    asciiquarium
    cmatrix
    cowsay
    lolcat
    vimgolf
  ];

  home.file = {
    ".hushlogin".text = "";
  };
}
