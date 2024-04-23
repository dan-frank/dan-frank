{ lib, config, ... }:
let
  cfg = config.programs.apps.terminal;
in {
  imports = [
    ./alacritty
    ./kitty
  ];

  options.programs.apps.terminal = {
    enable = lib.mkEnableOption "Enables terminal and configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.apps.terminal = {
      alacritty.enable = false;
      kitty.enable = true;
    };
  };
}
