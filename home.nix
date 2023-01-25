# Setup ideas
# - https://sourcegraph.com/github.com/knl/dotskel/-/blob/home.nix?L532:17
# - [zsh plugin func] https://sourcegraph.com/github.com/Icy-Thought/Snowflake/-/blob/modules/shell/zsh.nix

{ config, pkgs, ... }:
let
  pkgs = import <nixpkgs> { };
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
    
    # Theme
    nerdfonts

    # CLI Tools
    ripgrep
    vifm
    ls-colors
    bottom
    neofetch
    # macchina
    tree

    # Apps
    vscode # Code editor
    utm # Virtual machine

    # Fun
    asciiquarium
    cmatrix
    cowsay
    lolcat
  ];

  home.file = {
    ".hushlogin".text = "";
  };

  programs.alacritty = import ./config/alacritty.nix pkgs;
  programs.bat = import ./config/bat.nix pkgs;
  programs.git = import ./config/git.nix pkgs;
  programs.neovim = import ./config/neovim.nix pkgs;
  programs.vscode = import ./config/vscode.nix pkgs;
  programs.zsh = import ./config/zsh.nix pkgs;
}

