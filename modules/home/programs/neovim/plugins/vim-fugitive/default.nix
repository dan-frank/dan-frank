{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    plugin = vim-fugitive;
    type = "lua";
    config = ''
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    '';
  }];
}
