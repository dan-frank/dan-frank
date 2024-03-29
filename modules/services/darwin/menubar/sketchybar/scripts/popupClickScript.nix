{ pkgs }:
pkgs.writeShellScript "popupOff.sh" ''
  sketchybar --set "$NAME" popup.drawing=toggle
''