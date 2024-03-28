{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    plenary-nvim
    {
      plugin = harpoon;
      type = "lua";
      config = builtins.readFile ./init.lua;
    }
  ];
}
