{ lib, ... }:
let
  options = import ./../../../../options { inherit lib; };
in {
  inherit (options) blur-radius background;
}