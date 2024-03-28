{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    plenary-nvim
    popup-nvim

    {
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile ./init.lua;
    }
    telescope-fzy-native-nvim
  ];
}
