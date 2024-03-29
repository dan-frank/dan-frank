{ lib, ... }:
lib.mkOption {
  default = 25;
  type = lib.types.int;
  description = "Height of the bar";
}
