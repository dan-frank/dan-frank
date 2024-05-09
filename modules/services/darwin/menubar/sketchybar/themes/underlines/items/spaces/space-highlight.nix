{ pkgs, ...  }:
pkgs.writeShellScript "space-highlight.sh" ''
  args=()

  if [ "$SELECTED" = "true" ]; then
    args+=(--set space."$DID".label label=''${NAME#"space.$DID."} \
          --set $NAME icon.background.y_offset=-9              )
  else
    args+=(--set $NAME icon.background.y_offset=-20)
  fi

  sketchybar -m --animate tanh 0 "''${args[@]}"

  WIN=$(yabai -m query --spaces --space $SID | jq '.windows[0]')
  HAS_WINDOWS_OR_IS_SELECTED="true"
  if [ "$WIN" = "null" ] && [ "$SELECTED" = "false" ];then
    HAS_WINDOWS_OR_IS_SELECTED="false"
  fi
  sketchybar --set $NAME background.drawing=$SELECTED \
                         icon.highlight=$HAS_WINDOWS_OR_IS_SELECTED
''
