{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI Tools
    ripgrep
    vifm
    ls-colors
    bottom
    freshfetch # neofetch, macchina
    tree
    less

    # Fun
    asciiquarium
    cmatrix
    cowsay
    lolcat
  ];

  home.file = {
    ".hushlogin".text = "";
    ".p10k.zsh".source = link ./../dotfiles/p10k.zsh;
  };
}

