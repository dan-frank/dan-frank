{ pkgs, ...  }:
pkgs.writeShellScript "script.sh" ''
  sketchybar --set "$NAME" label="$(echo "$INFO" | jq .[])"
''
