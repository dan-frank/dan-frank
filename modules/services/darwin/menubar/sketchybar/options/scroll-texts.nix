{ lib, ... }:
lib.mkOption {
  default = false;
  type = lib.types.bool;
  description = "Controls the automatic scroll of all items texts, which are truncated by the max_chars property";
}
