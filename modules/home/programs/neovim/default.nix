# Helpful
# - https://sourcegraph.com/github.com/cbrewster/nix-home/-/blob/home/neovim.nix
{ config, lib, pkgs, inputs, ... }:
let
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = pkgs.callPackage ./plugins.nix { inherit config pkgs inputs; };
    extraConfig = ''
      syntax on

      lua << EOF
      require('github-theme').setup({
          theme_style = 'dark',
          dark_float = true,
      })
      EOF

      lua require('init')
    '';

    extraPackages = with pkgs; [
      # LSPs
      # nodePackages.coc-metals

      # Webdev
      nodePackages.graphql-language-service-cli
      nodePackages."@tailwindcss/language-server"
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      phpactor

      # Writing
      marksman
      ltex-ls

      # Other
      nodePackages.bash-language-server
      rnix-lsp
      sumneko-lua-language-server
    ];
  };

  xdg.configFile = {
    "nvim/lua" = {
      source = ./config;
      recursive = true;
    };
  };
}
