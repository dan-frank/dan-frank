{ pkgs, ...  }:
pkgs.writeShellScript "script.sh" ''
  sketchybar --set $NAME label="$(date '+%d %b %Y - %H:%M')"
''
