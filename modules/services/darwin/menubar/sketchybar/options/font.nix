{ lib, ... }:
{
  family = lib.mkOption {
    default = "Hack Nerd Font";
    type = lib.types.string;
    description = "The font family to be used for the text";
  };

  style = lib.mkOption {
    default = "Bold";
    type = lib.types.string;
    description = "The font style to be used for the text";
  };

  size = lib.mkOption {
    default = 14.0;
    type = lib.types.float;
    description = "The font size to be used for the text";
  };
}