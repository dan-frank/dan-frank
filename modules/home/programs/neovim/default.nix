{ pkgs, ... }:
{
  imports = [
    ./plugins
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      syntax on
    '';
    extraLuaConfig = ''
      ${builtins.readFile ./options/settings.lua}
      ${builtins.readFile ./options/remaps.lua}
      ${builtins.readFile ./options/lsp.lua}
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
}
