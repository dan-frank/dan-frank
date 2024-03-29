{ lib, ... }:
lib.mkOption {
  default = 0;
  type = lib.types.int;
  description = "Border width of the border";
}
