{ pkgs, lib, config, ... }:
let
  cfg = config.programs.cli.ripgrep;
in {
  options.programs.cli.ripgrep = {
    enable = lib.mkEnableOption "Enables ripgrep and configuration";
  };

  config = lib.mkIf cfg.enable {
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
