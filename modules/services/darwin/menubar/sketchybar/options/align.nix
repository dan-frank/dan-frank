{ lib, ... }:
lib.mkOption {
  default = "left";
  type = lib.types.enum [ "center" "left" "right" ];
  description = "Aligns the text in its container when it has a fixed width larger than the content width";
}
