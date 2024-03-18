{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    {
      plugin = lualine-nvim;
      type = "lua";
      config = builtins.readFile ./init.lua;
    }
    nvim-web-devicons
  ];
}
