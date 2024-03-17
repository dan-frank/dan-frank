{ pkgs, ... }:
with pkgs.vimPlugins;
{
  imports = [
    # Theme
    ./nvim-base16
    ./indent-blankline-nvim
    ./lualine-nvim
    ./todo-comments-nvim

    # Git
    ./harpoon
    ./vim-fugitive
    ./gitsigns-nvim
    ./copilot-lua

    # Editor
    ./undotree
    ./telescope
    ./treesitter
    ./lsp
  ];

  programs.neovim.plugins = [
    # Theme
    rainbow_parentheses
    rainbow-delimiters-nvim

    # Git
    git-messenger-vim

    # Lua libs
    plenary-nvim
    popup-nvim
  ];
}
