{ config, pkgs, lib, ... }:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in {
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # CLI Tools
    coreutils
    ripgrep
    vifm
    bottom
    neofetch # freshfetch macchina
    tree
    less

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

