{ pkgs }:
let
  hss-hyrax = import ./hyrax.nix { inherit pkgs; };
  hss-hyrax-protocols = import ./hyrax-protocols.nix { inherit pkgs; };
  hss-hyrax-search = import ./hyrax-search.nix { inherit pkgs; };
in
pkgs.writeShellApplication {
  name = "hss-hyrax-all";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    hss-hyrax "$1/hyrax";
    hss-hyrax-protocols "$1/protocols";
    hss-hyrax-search "$1/search";
  '';
}
