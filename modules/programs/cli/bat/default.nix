{ pkgs, lib, config, ... }:
let
  cfg = config.programs.cli.bat;

  base16theme = pkgs.writeText "base16.tmTheme" (import ./theme.nix config.colorscheme);
in {
  options.programs.cli.bat = {
    enable = lib.mkEnableOption "Enables bat and configuration";
  };

  config = lib.mkIf cfg.enable {
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
