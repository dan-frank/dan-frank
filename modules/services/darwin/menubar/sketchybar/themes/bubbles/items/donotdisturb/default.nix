{ pkgs, config, ...  }:
let
  script = import ./script.nix { inherit pkgs config; };
in pkgs.writeShellScript "donotdisturb.sh" ''
  dnd=(
    script="${script}"
    label.drawing=off
    icon=􀆺
    --add event focus_on "_NSDoNotDisturbEnabledNotification"
    --add event focus_off "_NSDoNotDisturbDisabledNotification"
    --subscribe dnd focus_on focus_off mouse.clicked
  )

  sketchybar             \
    --add item dnd right \
    --set dnd "''${dnd[@]}"
''
