{ config, pkgs, inputs, ... }:
with config.colorscheme.colors;
let
  inherit (pkgs)
    fetchFromGitHub
    # lua53Packages
    vimPlugins
    vimUtils;
in
with vimPlugins; [
  # Editor
  {
    plugin = nvim-base16;
    type = "lua";
    config = ''
      require('base16-colorscheme').setup({
          base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
          base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
          base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
          base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
      })
    '';
  }
  rainbow_parentheses
  {
    plugin = indent-blankline-nvim;
    type = "lua";
    config = builtins.readFile ./config/plugins/indent-blankline-nvim.lua;
  }
  {
    plugin = lualine-nvim;
    type = "lua";
    config = builtins.readFile ./config/plugins/lualine-nvim.lua;
  }
  {
    plugin = todo-comments-nvim;
    type = "lua";
    config = ''
      require('todo-comments').setup{}
    '';
  }

  {
    plugin = harpoon;
    type = "lua";
    config = builtins.readFile ./config/plugins/harpoon.lua;
  }
  {
    plugin = vim-fugitive;
    type = "lua";
    config = ''
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    '';
  }
  {
    plugin = gitsigns-nvim;
    type = "lua";
    config = builtins.readFile ./config/plugins/gitsigns-nvim.lua;
  }
  git-messenger-vim
  {
    plugin = copilot-lua;
    type = "lua";
    config = builtins.readFile ./config/plugins/copilot.lua;
  }
  {
    plugin = undotree;
    type = "lua";
    config = ''
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    '';
  }
  rainbow-delimiters-nvim

  # Lua libs
  plenary-nvim
  popup-nvim

  {
    plugin = telescope-nvim;
    type = "lua";
    config = builtins.readFile ./config/plugins/telescope-nvim.lua;
  }
  telescope-fzy-native-nvim

  # LSP
  nvim-lspconfig
  nvim-dap
  {
    plugin = nvim-cmp;
    type = "lua";
    config = builtins.readFile ./config/plugins/nvim-cmp.lua;
  }
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  cmp-path
  cmp-buffer
  luasnip
  cmp_luasnip
  nvim-jdtls
  {
    plugin = nvim-metals;
    type = "lua";
    config = builtins.readFile ./config/plugins/nvim-metals.lua;
  }

  {
    plugin = (nvim-treesitter.withPlugins (plugins:
      with plugins; [
        # https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/development/tools/parsing/tree-sitter/grammars
        tree-sitter-bash
        tree-sitter-bibtex
        tree-sitter-comment
        tree-sitter-css
        tree-sitter-html
        tree-sitter-java
        tree-sitter-javascript
        tree-sitter-json
        tree-sitter-latex
        tree-sitter-lua
        tree-sitter-make
        tree-sitter-markdown
        tree-sitter-nix
        tree-sitter-php
        tree-sitter-regex
        tree-sitter-scala
        tree-sitter-scss
        tree-sitter-vim
        tree-sitter-yaml
      ])
    );
    type = "lua";
    config = builtins.readFile ./config/plugins/nvim-treesitter.lua;
  }
  nvim-ts-autotag
]
