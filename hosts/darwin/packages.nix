{ pkgs, ... }:
let
  nb-script = import ./../../scripts/darwin/nb.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    nb-script
  ];
}
