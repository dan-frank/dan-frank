{ lib, ... }:
lib.mkOption {
  default = false;
  type = lib.types.bool;
  # type = lib.types.union [
  #   lib.types.bool
  #   (lib.types.enum ["window"])
  # ];
  description = "If the bar should be drawn on top of everything, or on top of all windows";
}
