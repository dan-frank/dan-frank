{ lib, ... }:
let
  options = import ./default.nix { inherit lib; };
in {
  inherit (options) drawing color border-color border-width height corner-radius padding y-offset image shadow;

  clip = lib.mkOption {
    default = 0.0;
    type = lib.types.float;
    description = "By how much the background clips the bar (i.e. transparent holes in the bar)";
  };
}