{ lib, ... }:
lib.makeOverridable lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Width of the item";
}
