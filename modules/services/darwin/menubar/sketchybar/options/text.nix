{ lib, ... }:
let
  options = import ./default.nix { inherit lib; };
in {
  inherit (options) drawing color padding y-offset highlight-color align font background shadow;

  highlight = lib.mkOption {
    default = true;
    type = lib.types.bool;
    description = "If the text uses the `highlight_color` or the regular `color`";
  };

  string = lib.mkOption {
    default = "";
    type = lib.types.str;
    description = "Sets the text to the specified string";
  };

  scroll-duration = lib.mkOption {
    default = 100;
    type = lib.types.int;
    description = "Sets the scroll speed of text trucated by max_chars on items with scroll_texts enabled";
  };

  max-chars = lib.mkOption {
    default = 0;
    type = lib.types.int;
    description = "Sets the maximum characters to display (can be scrolled via the items scroll_texts property)";
  };

  width = lib.mkOption {
    default = 0;
    type = lib.types.int;
    # dynamic
    description = "Makes the text use a fixed width given in points";
  };
}
