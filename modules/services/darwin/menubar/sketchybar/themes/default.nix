{ pkgs, lib, config, ... }:
{
  bubbles = import ./bubbles { inherit pkgs lib config; };
  minimal = import ./minimal { inherit pkgs lib config; };
  underlines = import ./underlines { inherit pkgs lib config; };
}