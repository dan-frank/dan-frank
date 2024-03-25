{ pkgs, ... }:
with pkgs.vimPlugins;
{
  imports = [
    # Theme
    ./indent-blankline-nvim
    ./lualine-nvim
    ./base16-nvim
    ./todo-comments-nvim

    # Git
    ./git

    # Editor
    ./harpoon
    ./lsp
    ./telescope
    ./treesitter
    ./undotree
  ];

  programs.neovim.plugins = [
    # Theme
    rainbow_parentheses
    rainbow-delimiters-nvim
  ];
}
