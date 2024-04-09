{ lib, ... }:
let
  # TODO: get from cfg.options ?
  options = import ./../default.nix { inherit lib; };
in {
  inherit (options) color border-color border-width corner-radius padding y-offset blur-radius text topmost;

  height = options.height.override {
    default = 36;
  };

  position = lib.mkOption {
    default = "top";
    type = lib.types.enum ["top" "bottom"];
    description = "Position of the bar on the screen";
  };

  margin = lib.mkOption {
    default = 0;
    type = lib.types.int;
    description = "Margin around the bar";
  };

  notch-width = lib.mkOption {
    default = 200;
    type = lib.types.int;
    description = "The width of the notch to be accounted for on the internal display";
  };

  notch-offset = lib.mkOption {
    default = 0;
    type = lib.types.int;
    description = "Additional y_offset exclusively applied to notched screens";
  };

  display = lib.mkOption {
    default = "all";
    type = lib.types.enum ["main" "all"];
    # Or list of ints
    description = "Display to show the bar on";
  };

  hidden = lib.mkOption {
    default = false;
    type = lib.types.bool;
    # current
    description = "If all / the current bar is hidden";
  };

  sticky = lib.mkOption {
    default = true;
    type = lib.types.bool;
    description = "Makes the bar sticky during space changes";
  };

  font-smoothing = lib.mkOption {
    default = false;
    type = lib.types.bool;
    description = "If fonts should be smoothened";
  };

  shadow = lib.mkOption {
    default = false;
    type = lib.types.bool;
    description = "If the bar should draw a shadow";
  };
}