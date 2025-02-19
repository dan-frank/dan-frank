{ pkgs, ... }:
{
  fontProfiles = {
    enable = true;
    monospace = {
      family = "Iosevka Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
    };
    regular = {
      family = "Iosevka";
      package = pkgs.iosevka;
    };
    fontSize = 16;
  };
}
