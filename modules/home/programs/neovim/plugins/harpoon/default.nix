{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    plugin = harpoon;
    type = "lua";
    config = builtins.readFile ./init.lua;
  }];
}
