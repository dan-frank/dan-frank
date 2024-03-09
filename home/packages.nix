{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;
  programs.java.enable = true; # <- HSS

  home.packages = with pkgs; [
    # CLI Tools
    ripgrep
    vifm
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
    ".p10k.zsh".source = link ./../dotfiles/p10k.zsh;
  };
}

