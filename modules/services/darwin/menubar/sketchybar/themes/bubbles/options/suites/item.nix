{ lib, ... }:
let
  options = import ./../../../../options { inherit lib; };
in {
  inherit (options) background scroll-texts;

  icon = {
    inherit (options) background color highlight-color padding;
  };

  label = {
    inherit (options) color highlight-color padding;
  };
}
