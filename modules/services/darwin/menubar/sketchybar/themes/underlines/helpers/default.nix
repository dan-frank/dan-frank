{ config, ... }:
let
  helpers = import ./../../../helpers { inherit config; };
in helpers // {
  getColor = import ./getColor.nix { inherit config; };
}
