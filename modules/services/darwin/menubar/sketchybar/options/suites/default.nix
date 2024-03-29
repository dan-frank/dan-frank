{ lib, ... }:
{
  bar = import ./bar.nix { inherit lib; };
}
