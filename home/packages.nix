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

  # Throwing error:
  # | Creating home file links in /Users/dan
  # | ln: failed to create symbolic link '/Users/dan/Applications/Home Manager Apps': Permission denied
  # home.file = {
  #   ".hushlogin".text = "";
  #   ".p10k.zsh".source = link ./../dotfiles/p10k.zsh;
  # };
}

