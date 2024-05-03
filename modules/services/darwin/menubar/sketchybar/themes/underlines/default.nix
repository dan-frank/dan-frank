# Reference -> https://github.com/FelixKratz/SketchyBar/discussions/47?sort=top#discussioncomment-3587227
# Dotfiles  -> https://github.com/itaysharir/Dotfiles/tree/main/dmenu/themes/sketchybar/sketchybar-dt-xmonad
{ pkgs, lib, config, ... }:
with config.colorscheme.palette;
let
  cfg = config.services.darwin.sketchybar;
  sketchybarrc = import ./sketchybarrc.nix { inherit pkgs config; };

  helpers = import ./helpers { inherit config; };
  inherit (helpers) getColor;
in {
  config = lib.mkIf cfg.enable {
    services.sketchybar = {
      config = builtins.readFile sketchybarrc;
      extraPackages = with pkgs; [ jq ];
    };

    fonts.fonts = with pkgs; [
      font-awesome
    ];

    services.darwin.sketchybar = {
      font = {
        style = "Regular";
        size = 12.0;
      };

      bar = {
        background.padding = cfg.bar.padding;
        blur-radius = 0;
        border-width = 0;
        color = getColor { color = "bar-color"; };
        corner-radius = 0;
        drawing = true;
        font-smoothing = false;
        height = 34;
        icon = {
          color = getColor { color = "icon-color"; };
          font = cfg.font // {
            family = "Font Awesome 6 Free";
            style = "Solid";
            size = 14.0;
          };
          padding = cfg.bar.padding;
        };
        label = {
          color = getColor { color = "label-color"; };
          font = cfg.font // {
            style = "Bold";
            size = 13.0;
          };
          padding = cfg.bar.padding;
        };
        margin = 0;
        padding = 4;
        position = "top";
        sticky = true;
        topmost = false;
        text = {
          color = "0xff${base05}";
          padding = 6;
        };
        y-offset = -100;
      };
    };
  };
}
