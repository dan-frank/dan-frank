{ config, pkgs, lib, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      # TODO: Create GitHub Dark theme -> https://github.com/sharkdp/bat#adding-new-themes
      theme = "TwoDark";
      italic-text = "always";
    };
  };
}
