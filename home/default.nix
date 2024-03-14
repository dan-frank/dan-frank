{
  imports = [
    ./../settings/colors.nix
    ./../settings/fontProfiles.nix
    ./fonts.nix

    ./config-files.nix
    ./git.nix
    ./packages.nix
    ./shells.nix
    ./terminal.nix

    ./../modules/home/programs/bash
    ./../modules/home/programs/zsh

    ./../modules/home/programs/bat
    ./../modules/home/programs/firefox
    ./../modules/home/programs/lsd
    ./../modules/home/programs/neovim
    ./../modules/home/programs/ripgrep
    ./../modules/home/programs/vscode
    ./../modules/home/programs/zoxide
  ];
}
