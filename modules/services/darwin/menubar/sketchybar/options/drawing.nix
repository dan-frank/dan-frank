{ lib, ... }:
lib.mkOption {
  default = true;
  type = lib.types.bool;
  description = "Whether to draw item";
}
