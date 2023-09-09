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
  github-nvim-theme
  rainbow_parentheses
  indentLine
  lualine-nvim

  harpoon
  vim-fugitive
  gitsigns-nvim
  git-messenger-vim
  undotree

  # Lua libs
  plenary-nvim
  popup-nvim

  telescope-nvim
  telescope-fzy-native-nvim
  nvim-ts-rainbow
  nvim-ts-autotag

  # LSP
  nvim-lspconfig
  nvim-jdtls
  nvim-metals

  nvim-cmp
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
    plugin = todo-comments-nvim;
    type = "lua";
    config = ''
      require('todo-comments').setup{}
    '';
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
    config = ''
    '';
  }
]
