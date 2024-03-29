{ lib, ... }:
let
  options = import ./../../../../options { inherit lib; };
in {
  inherit (options) background padding scroll-texts;

  icon = {
    inherit (options) color padding;
  };
}