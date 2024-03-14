{ config, pkgs, lib, ... }:
let
  base16theme = pkgs.writeText "base16.tmTheme" (import ./theme.nix config.colorscheme);
in
{
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
      theme = "base16";
    };
    themes."base16".src = base16theme;
  };

  home.shellAliases = {
    cat = "bat";
  };
}
