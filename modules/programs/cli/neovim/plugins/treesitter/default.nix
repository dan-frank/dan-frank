{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
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
        ]
      ));
      type = "lua";
      config = builtins.readFile ./init.lua;
    }
    nvim-ts-autotag
  ];
}
