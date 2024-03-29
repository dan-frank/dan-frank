{ pkgs, lib, config, ... }:
let
  cfg = config.programs.cli.neovim;
in {
  options.programs.cli.neovim = {
    enable = lib.mkEnableOption "Enables neovim and configuration";
  };

  imports = [
    ./plugins
  ];

  config = lib.mkIf cfg.enable {
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
        nil # Nix

        # Webdev
        nodePackages.graphql-language-service-cli
        nodePackages."@tailwindcss/language-server"
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        nodePackages.yaml-language-server
        phpactor # PHP

        # Writing
        marksman # Markdown
        ltex-ls # Latex

        # Other
        nodePackages.bash-language-server # Bash
        sumneko-lua-language-server # Lua
      ];
    };
  };
}
