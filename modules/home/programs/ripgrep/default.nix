{ config, pkgs, lib, ... }:
{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--colors=line:style:bold"
      # Search case-insensitively if pattern is all lowercase.
      "--smart-case"
    ];
  };
}
