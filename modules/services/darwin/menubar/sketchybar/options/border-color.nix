{ lib, ... }:
lib.mkOption {
  default = "0xffff0000";
  type = lib.types.string;
  description = "Color of the border";
  example = "<argb_hex>";
}