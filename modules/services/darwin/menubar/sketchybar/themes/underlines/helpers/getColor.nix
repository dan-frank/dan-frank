{ config, ... }:
with config.colorscheme.palette;
{ color, opacity ? null }:
let
  colors = {
    black = "0xff${base00}";
    white = "0xff${base07}";
    red = "0xff${base08}";
    green = "0xff${base0B}";
    blue = "0xff${base0D}";
    cyan = "0xff${base0C}";
    yellow = "0xff${base0A}";
    orange = "0xff${base09}";
    magenta = "0xff${base0F}";
    grey = "0xff${base03}";
    transparent = "0x00000000";

    # Move these?
    bar-color = colors.black; # Grey bar
    icon-color = colors.white; # Color of all icons
    label-color = colors.white; # Color of all labels

    popup-background-color = colors.bar-color;
    popup-border-color = colors.green;

    shadow-color = colors.black;

    # Item specific special colors
    git-no-commits = "0xffd3d3d3";
    spotify-green = "0xff1db954";
    vim = "";
  };

  # foundColor = colors.${color};
in colors.${color}
