{ pkgs, lib, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  options = import ./options { inherit lib; };
  themes = import ./themes { inherit pkgs lib config; };
in {
  imports = [ themes.bubbles ];

  options.services.darwin.sketchybar = {
    enable = lib.mkEnableOption "Enables Sketchybar and configuration";

    inherit (options.suites) bar;
    inherit (options) font;
  };

  config = lib.mkIf cfg.enable {
    services.sketchybar = {
      enable = true;
      extraPackages = with pkgs; [ jq ];
    };

    system.defaults.NSGlobalDomain._HIHideMenuBar = true;

    services.yabai.config = lib.mkIf config.services.darwin.yabai.enable {
      external_bar = if cfg.bar.position == "top" then
        "all:${toString cfg.bar.height}:0"
      else
        "all:0:${toString cfg.bar.height}";
    };

    services.darwin.sketchybar = {
      font = {
        family = config.fontProfiles.monospace.family;
      };
    };
  };
}
