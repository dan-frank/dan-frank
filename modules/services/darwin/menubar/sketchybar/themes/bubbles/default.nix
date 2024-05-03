# Reference -> https://github.com/FelixKratz/SketchyBar/discussions/47?sort=top#discussioncomment-7890276
# Dotfiles  -> https://github.com/Pe8er/dotfiles/tree/master/config.symlink/sketchybar
{ pkgs, lib, config, ... }:
let
  cfg = config.services.darwin.sketchybar;
  sketchybarrc = import ./sketchybarrc.nix { inherit pkgs config; };

  suites = import ./options/suites { inherit lib config; };

  helpers = import ./helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in {
  options.services.darwin.sketchybar = {
    inherit (suites) bracket item menu menuItem notification separator;
  };

  config = lib.mkIf cfg.enable {
    services.sketchybar = {
      config = builtins.readFile sketchybarrc;
      extraPackages = with pkgs; [
        jq
        gh
        # ical-buddy
        # sketchybar-helper
      ];
    };

    # https://sourcegraph.com/github.com/Cu3PO42/gleaming-glacier@5abb8c0a3fb72cafbc7ca113e5f135142d0b51c8/-/blob/features/darwin/wm.nix?L116:5-116:15
    # https://sourcegraph.com/github.com/Cu3PO42/gleaming-glacier@5abb8c0a3fb72cafbc7ca113e5f135142d0b51c8/-/blob/packages/ical-buddy.nix
    fonts.fonts = with pkgs; [
      # sketchybar-app-font
      # liga-sfmono-nerd-font
      # font-awesome
    ];

    homebrew = {
      # casks = [
      #   "sf-symbols"
      # ];
      brews = [
        "ical-buddy"
      ];
    };

    services.darwin.sketchybar = {
      font = {
        style = "Regular";
        size = 16.0;
      };

      bar = {
        color = getColor { color = "black"; opacity = "o0"; };
        border-color = getColor { color = "black"; };
        position = "top";
        height = 32;
        margin = 0;
        y-offset = 0;
        corner-radius = 0;
        border-width = 0;
        blur-radius = 0;
        padding = 12;
        notch-width = 160;
        notch-offset = 0;
        display = "all";
        hidden = false;
        topmost = false;
        sticky = true;
        font-smoothing = false;
        shadow = false;
      };

      bracket = {
        background = {
          color = getColor { color = "black"; opacity = "o25"; };
          corner-radius = 8;
          height = 24;
        };
        blur-radius = 32;
      };

      item = {
        background = {
          padding = 4;
        };
        icon = {
          background = {
            corner-radius = 4;
            height = 18;
          };
          color = getColor { color = "white"; };
          highlight-color = getColor { color = "teal"; };
          padding = 4;
        };
        label = {
          color = getColor { color = "white"; };
          highlight-color = getColor { color = "teal"; };
          padding = 4;
        };
        scroll-texts = true;
      };

      menu = {
        blur-radius = 32;
        background = {
          color = getColor { color = "black"; opacity = "o25"; };
          corner-radius = 8;
          shadow = {
            drawing = true;
            color = getColor { color = "black"; opacity = "o50"; };
            angle = 90;
            distance = 16;
          };
        };
      };

      menuItem = {
        background = {
          color = getColor { color = "black"; opacity = "o25"; };
        };
        icon = {
          padding = 0;
          color = getColor { color = "white"; };
        };
        padding = 8;
        scroll-texts = true;
      };

      notification = {
        background = {
          color = getColor { color = "white"; opacity = "o25"; };
          corner-radius = 16;
          height = 16;
        };
        drawing = true;
        icon = {
          padding = 8;
          color = getColor { color = "black"; opacity = "o75"; };
        };
        label = {
          padding = 8;
          color = getColor { color = "black"; opacity = "o75"; };
        };
        update-frequency = 120;
        updates = true;
      };

      separator = {
        background = {
          color = getColor { color = "white"; opacity = "o25"; };
          height = 1;
          y-offset = -16;
        };
        width = 180;
      };
    };
  };
}
