{ pkgs, lib, config, ... }:
let
  cfg = config.programs.cli.zoxide;
in {
  options.programs.cli.zoxide = {
    enable = lib.mkEnableOption "Enables zoxide and configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
