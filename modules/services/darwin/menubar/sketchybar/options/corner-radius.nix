{ lib, ... }:
lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Corner radius of the bar";
}
