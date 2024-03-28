{ pkgs, lib, config, ... }:
{
  options = {
    ripgrep.enable = lib.mkEnableOption "Enables ripgrep and configuration";
  };

  config = lib.mkIf config.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
      arguments = [
        "--colors=line:style:bold"
        # Search case-insensitively if pattern is all lowercase.
        "--smart-case"
      ];
    };
  };
}
