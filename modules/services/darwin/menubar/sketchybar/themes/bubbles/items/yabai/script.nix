{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  colors = import ./../../colors.nix { inherit pkgs config; };
  icons = import ./../../icons.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "yabai-script.sh" ''
  source ${colors}
  source ${icons}

  set_icon() {
    COLOR=$LABEL_COLOR

    WINDOW=$(yabai -m query --windows --window)
    read -r FLOATING SPLIT PARENT FULLSCREEN STICKY STACK_INDEX <<<$(echo "$WINDOW" | jq -rc '.["is-floating", "split-type", "has-parent-zoom", "has-fullscreen-zoom", "is-sticky", "stack-index"]')

    if [[ $STACK_INDEX -gt 0 ]]; then
      LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
      ICON=$YABAI_STACK
      LABEL="$(printf "%s/%s" "$STACK_INDEX" "$LAST_STACK_INDEX")"
      COLOR=${getColor { color = "yellow"; }}
    elif [[ $FLOATING == "true" ]]; then
      ICON=$YABAI_FLOAT
    elif [[ $PARENT == "true" ]]; then
      ICON="􁈔"
    elif [[ $FULLSCREEN == "true" ]]; then
      ICON=$YABAI_FULLSCREEN_ZOOM
    elif [[ $SPLIT == "vertical" ]]; then
      ICON=$YABAI_SPLIT_VERTICAL
    elif [[ $SPLIT == "horizontal" ]]; then
      ICON=$YABAI_SPLIT_HORIZONTAL
    else
      ICON=$YABAI_GRID
    fi

    args=(--bar border_color="$COLOR" --animate tanh 10 --set "$NAME" icon="$ICON" icon.color="$COLOR")

    [ -z "$LABEL" ] && args+=(label.drawing=off) ||
      args+=(label.drawing=on label="$LABEL" label.color="$COLOR")

    [ -z "$ICON" ] && args+=(icon.width=0) ||
      args+=(icon="$ICON")

    sketchybar -m "''${args[@]}"
  }

  mouse_clicked() {
    YABAI_MODE=$(yabai -m query --spaces --space | jq -r .type)

    if [[ $YABAI_MODE == "bsp" ]]; then
      YABAI_MODE="stack"
    else
      YABAI_MODE="bsp"
    fi

    yabai -m space --layout "$YABAI_MODE"

    set_icon
  }

  case "$SENDER" in
    "mouse.clicked" | "alfred_trigger")
      mouse_clicked
      ;;
    "window_focus" | "front_app_switched" | "update_yabai_icon" | "space_windows_change")
      set_icon
      ;;
  esac
''
