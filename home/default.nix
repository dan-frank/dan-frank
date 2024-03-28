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

  bash.enable = true;
  zsh.enable = true;

  alacritty.enable = true;
  bat.enable = true;
  firefox.enable = true;
  lsd.enable = true;
  neovim.enable = true;
  ripgrep.enable = true;
  vscode.enable = true;
  zoxide.enable = true;
}
