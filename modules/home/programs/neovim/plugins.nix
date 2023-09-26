{ config, pkgs, inputs, ... }:
let
  inherit (pkgs)
    fetchFromGitHub
    # lua53Packages
    vimPlugins
    vimUtils;

  github-nvim-theme = vimUtils.buildVimPluginFrom2Nix {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "b3f15193d1733cc4e9c9fe65fbfec329af4bdc2a";
      sha256 = "wLX81wgl4E50mRig9erbLyrxyGbZllFbHFAQ9+v60W4=";
    };
  };
in
with vimPlugins; [
  # Editor
  {
    plugin = github-nvim-theme;
    type = "lua";
    config = ''
      require('github-theme').setup({
        theme_style = 'dark',
        dark_float = true,
      })
    '';
  }
  rainbow_parentheses
  indentLine
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
    plugin = undotree;
    type = "lua";
    config = ''
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    '';
  }

  # Lua libs
  plenary-nvim
  popup-nvim

  {
    plugin = telescope-nvim;
    type = "lua";
    config = builtins.readFile ./config/plugins/telescope-nvim.lua;
  }
  telescope-fzy-native-nvim
  nvim-ts-rainbow
  nvim-ts-autotag

  # LSP
  nvim-lspconfig
  nvim-jdtls
  {
    plugin = nvim-metals;
    type = "lua";
    config = builtins.readFile ./config/plugins/nvim-metals.lua;
  }

  {
    plugin = nvim-cmp;
    type = "lua";
    config = builtins.readFile ./config/plugins/nvim-cmp.lua;
  }
  nvim-dap
  cmp-nvim-lsp
  cmp-nvim-lsp-signature-help
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp-nvim-lua
  cmp-emoji
  luasnip
  cmp_luasnip

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
]
