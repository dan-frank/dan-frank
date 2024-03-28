{ pkgs, lib, config, ... }:
{
  options = {
    zoxide.enable = lib.mkEnableOption "Enables zoxide and configuration";
  };

  config = lib.mkIf config.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
