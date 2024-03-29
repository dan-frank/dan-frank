{ pkgs }:
pkgs.writeShellScript "popupOff.sh" ''
  sketchybar --set logo popup.drawing=off
''