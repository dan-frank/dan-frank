{ lib, ... }:
lib.mkOption {
  default = "0x44000000";
  type = lib.types.str;
  description = "Color of item";
  example = "<argb_hex>";
}
