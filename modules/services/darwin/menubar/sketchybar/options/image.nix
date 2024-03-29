{ lib, ... }:
let
  options = import ./default.nix { inherit lib; };
in {
  inherit (options) drawing color border-color border-width height corner-radius padding y-offset shadow;

  scale = lib.mkOption {
    default = 1.0;
    type = lib.types.float;
    description = "The scale factor that should be applied to the image";
  };

  string = lib.mkOption {
    type = lib.types.string;
    description = "The image to display in the bar";
    example = "<path>, app.<bundle-id>, app.<name>, media.artwork";
  };
}