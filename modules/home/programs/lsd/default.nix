{ config, pkgs, lib, ... }:
{
  programs.lsd = {
    enable = true;
    enableAliases = false;
    settings = {
      blocks = ["permission" "size" "user" "group" "date" "name"];
      date = "relative";
      header = true;
      icons.separator = "  ";
      sorting = {
        column = "name";
        dir-grouping = "first";
      };
    };
  };

  home.shellAliases = {
    ls = "lsd";
    ll = "lsd -l";
    la = "lsd -a";
    lla = "lsd -la";
    lt = "lsd --tree";
  };
}
