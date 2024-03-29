{ pkgs, lib, config, ... }:
{
  bubbles = import ./bubbles { inherit pkgs lib config; };
}