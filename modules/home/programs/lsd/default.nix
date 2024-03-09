{ config, pkgs, lib, ... }:
{
  programs.lsd = {
    enable = true;
    enableAliases = true;
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
}
