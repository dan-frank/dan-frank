{ lib, ... }:
let
  options = import ./../../../../options { inherit lib; };
in {
  inherit (options) background drawing;

  update-frequency = lib.mkOption {
    default = 120;
    type = lib.types.int;
    description = "";
  };

  updates = lib.mkOption {
    default = false;
    type = lib.types.bool;
    description = "";
  };

  icon = {
    inherit (options) color padding;
  };

  label = {
    inherit (options) color padding;
  };
}