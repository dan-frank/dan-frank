{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    plugin = gitsigns-nvim;
    type = "lua";
    config = builtins.readFile ./init.lua;
  }];
}
