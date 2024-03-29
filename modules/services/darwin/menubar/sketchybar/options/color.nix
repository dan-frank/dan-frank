{ lib, ... }:
lib.mkOption {
  default = "0x44000000";
  type = lib.types.string;
  description = "Color of item";
  example = "<argb_hex>";
}
