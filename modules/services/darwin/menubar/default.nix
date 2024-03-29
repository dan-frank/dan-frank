{ lib, config, ... }:
let
  cfg = config.services.darwin.menubar;
in {
  imports = [
    ./sketchybar
    ./spacebar
  ];

  options.services.darwin.menubar = {
    enable = lib.mkEnableOption "Enables menubar and configuration";
  };

  config = lib.mkIf cfg.enable {
    services.darwin = {
      sketchybar.enable = true;
      spacebar.enable = false;
    };
  };
}
