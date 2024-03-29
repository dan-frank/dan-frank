{ lib, ... }:
lib.makeOverridable lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Height of the item";
}
