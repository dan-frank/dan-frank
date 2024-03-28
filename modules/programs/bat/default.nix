{ pkgs, lib, config, ... }:
let
  base16theme = pkgs.writeText "base16.tmTheme" (import ./theme.nix config.colorscheme);
in
{
  options = {
    bat.enable = lib.mkEnableOption "Enables bat and configuration";
  };

  config = lib.mkIf config.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        italic-text = "always";
        theme = "base16";
      };
      themes."base16".src = base16theme;
    };

    home.shellAliases = {
      cat = "bat";
    };
  };
}
