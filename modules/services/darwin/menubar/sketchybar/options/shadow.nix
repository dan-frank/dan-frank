{ lib, ... }:
let
  options = import ./default.nix { inherit lib; };
in {
  inherit (options) drawing color;

  angle = lib.mkOption {
    default = 30;
    type = lib.types.int;
    description = "Angle of the shadow";
  };

  distance = lib.mkOption {
    default = 5;
    type = lib.types.int;
    description = "Distance of the shadow";
  };
}