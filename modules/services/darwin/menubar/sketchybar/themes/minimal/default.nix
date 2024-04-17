# Reference -> https://github.com/FelixKratz/SketchyBar/discussions/47?sort=top#discussioncomment-4946414
{ pkgs, lib, config, ... }:
with config.colorscheme.palette;
let
  cfg = config.services.darwin.sketchybar;
  sketchybarrc = import ./sketchybarrc.nix { inherit pkgs config; };
in {
  config = lib.mkIf cfg.enable {
    services.sketchybar = {
      config = builtins.readFile sketchybarrc;
    };

    services.darwin.sketchybar = {
      font = {
        style = "Regular";
        size = 14.0;
      };

      bar = {
        color = "0xff${base00}";
        position = "top";
        height = 36;
        padding = 12;
        sticky = true;
        text = {
          color = "0xff${base05}";
          padding = 6;
        };
      };
    };
  };
}
