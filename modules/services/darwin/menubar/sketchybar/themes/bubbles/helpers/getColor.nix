{ config, ... }:
with config.colorscheme.palette;
{ color, opacity ? null }:
let
  colors = {
    blue = "${base0D}";
    teal ="${base06}";
    cyan = "${base0C}";
    grey = "${base0E}";
    green = "${base0B}";
    yellow = "${base0A}";
    red = "${base08}";
    black = "${base01}";
    trueblack = "${base00}";
    white = "${base05}";
  };

  opacities = {
    o0 = "0x00";
    o10 = "0x1a";
    o25 = "0x40";
    o50 = "0x80";
    o75 = "0xbf";
    o100 = "0xff";
  };

  foundOpacity = opacities.${if isNull opacity then "o100" else opacity};
  foundColor = colors.${color};
in "${foundOpacity}${foundColor}"
