{ pkgs, ... }:
{
  popupClickScript = import ./popupClickScript.nix { inherit pkgs; };
  popupOff = import ./popupOff.nix { inherit pkgs; };
}