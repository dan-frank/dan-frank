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

    scrollback = lib.mkOption {
      default = 10000;
      type = lib.types.int;
      description = "Length of terminal line history for scrollback";
    };
  };


  config = lib.mkIf cfg.enable {
    programs.apps.terminal = {
      scrollback = 15000;

      alacritty.enable = false;
      kitty.enable = true;
    };
  };
}
