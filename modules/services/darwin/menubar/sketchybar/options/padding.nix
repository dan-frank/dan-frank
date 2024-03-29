{ lib, ... }:
lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Padding between leftmost and rightmost border";
}
