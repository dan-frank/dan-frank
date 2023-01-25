# Setup ideas
# - https://sourcegraph.com/github.com/knl/dotskel/-/blob/home.nix?L532:17
# - [zsh plugin func] https://sourcegraph.com/github.com/Icy-Thought/Snowflake/-/blob/modules/shell/zsh.nix

# { config, pkgs, ... }:
let
  # pkgs = import <nixpkgs> { };
  pkgs = import ./default.nix { };

  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    sha256 = "KsVuHBd4CzAWDeobS0N4NW+z1KMK1kBnZg14g67SCeQ=";
  };
  ls-colors = pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';
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

  programs.git = {
    enable = true;
    userName = "dan-frank";
    userEmail = "dan.frank.lucas@gmail.com";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = "false";
    };
  };

  programs.zsh = import ./config/zsh.nix pkgs;
  programs.alacritty = import ./config/alacritty.nix pkgs;
  programs.neovim = import ./config/neovim.nix pkgs;
  programs.vscode = import ./config/vscode.nix pkgs;
  programs.bat = import ./config/bat.nix pkgs;
}

