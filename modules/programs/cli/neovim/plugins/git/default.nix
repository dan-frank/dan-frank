{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    # {
    #   plugin = copilot-lua;
    #   type = "lua";
    #   config = builtins.readFile ./copilot.lua;
    # }
    {
      plugin = git-messenger-vim;
      type = "lua";
      config = builtins.readFile ./git-messenger-vim.lua;
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = builtins.readFile ./gitsigns-nvim.lua;
    }
    {
      plugin = vim-fugitive;
      type = "lua";
      config = builtins.readFile ./vim-fugitive.lua;
    }
  ];
}
