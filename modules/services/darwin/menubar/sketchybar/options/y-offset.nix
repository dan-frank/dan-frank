{ lib, ... }:
lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Vertical offset of the item from its default position";
}
