{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    plugin = indent-blankline-nvim;
    type = "lua";
    config = builtins.readFile ./init.lua;
  }];
}
