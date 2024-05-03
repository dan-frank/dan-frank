{ lib, ... }:
let
  options = import ./default.nix { inherit lib; };
in {
  inherit (options) color font padding;
}