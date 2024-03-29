{
  imports = [
    ./../settings/colors.nix
    ./../settings/fontProfiles.nix
    ./fonts.nix

    ./config-files.nix
    ./git.nix
    ./packages.nix
    ./shells.nix

    ./../modules/shells
    ./../modules/programs
  ];

  shells = {
    bash.enable = true;
    zsh.enable = true;
  };

  programs.apps = {
    alacritty.enable = true;
    firefox.enable = true;
    vscode.enable = true;
  };

  programs.cli = {
    bat.enable = true;
    lsd.enable = true;
    neovim.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };
}
