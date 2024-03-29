{ lib, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  options = import ./../../../../options { inherit lib; };
in {
  inherit (options) blur-radius background;
}