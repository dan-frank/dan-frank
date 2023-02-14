# Setup ideas
# - https://sourcegraph.com/github.com/knl/dotskel/-/blob/home.nix?L532:17
# - [zsh plugin func] https://sourcegraph.com/github.com/Icy-Thought/Snowflake/-/blob/modules/shell/zsh.nix

{ config, pkgs, ... }:
let
  pkgs = import <nixpkgs> { };

  link = config.lib.file.mkOutOfStoreSymlink;
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/Users/dan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    # Window Manager for Mac -> https://github.com/koekeishiya/yabai
    
    # CLI Tools
    ripgrep
    vifm
    # ls-colors
    bottom
    freshfetch # neofetch, macchina
    tree

    # Fun
    asciiquarium
    cmatrix
    cowsay
    lolcat
  ];

  home.file = {
    ".hushlogin".text = "";
    ".p10k.zsh".source = link ./../../dotfiles/p10k.zsh;
  };

  programs.alacritty = import ./../../modules/alacritty.nix pkgs;
  programs.bat = import ./../../modules/bat.nix pkgs;
  programs.git = import ./../../modules/git.nix pkgs;
  programs.neovim = import ./../../modules/neovim.nix pkgs;
  programs.vscode = import ./../../modules/vscode.nix pkgs;
  programs.zsh = import ./../../modules/zsh.nix pkgs;
}

