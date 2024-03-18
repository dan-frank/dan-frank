{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    {
      plugin = git-messenger-vim;
      type = "lua";
      config = builtins.readFile ./init.lua;
    }
  ];
}
