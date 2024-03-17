{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    plugin = copilot-lua;
    type = "lua";
    config = builtins.readFile ./init.lua;
  }];
}
