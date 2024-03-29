{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  colors = import ./../../colors.nix { inherit pkgs config; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "battery-script.sh" ''
  source ${colors}
  TMP="/tmp/drawing_state.txt"

  render_item() {
    PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    CHARGING=$(pmset -g batt | grep 'AC Power')
    COLOR="$ICON_COLOR"
    local DRAWING
    DRAWING=$(get_label_state)

    if [ "$PERCENTAGE" = "" ]; then
      exit 0
    fi

    case ''${PERCENTAGE} in
    9[0-9] | 100)
      ICON="􀛨"
      ;;
    [6-8][0-9])
      ICON="􀺸"
      ;;
    [3-5][0-9])
      ICON="􀺶"
      ;;
    [1-2][0-9])
      ICON="􀛩"
      COLOR=${getColor { color = "yellow"; }}
      DRAWING="on"
      ;;
    *)
      ICON="􀛪"
      COLOR=${getColor { color = "red"; }}
      DRAWING="on"
      ;;
    esac

    if [[ $CHARGING != "" ]]; then
      ICON="􀢋"
    fi

    sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="''${PERCENTAGE}%" label.color="$LABEL_COLOR" label.drawing="$DRAWING"
  }

  save_label_state() {
    (sketchybar --query "$NAME" | jq -r '.label.drawing') > "$TMP"
  }

  get_label_state() {
    if [ -e "$TMP" ]; then
      cat "$TMP"
    else
      echo "off" > "$TMP"
    fi
  }

  label_toggle() {
    if [[ $(get_label_state) == "on" ]]; then
      DRAWING="off"
    else
      DRAWING="on"
    fi

    sketchybar --set "$NAME" label.drawing="$DRAWING"
    save_label_state
  }

  case "$SENDER" in
  "mouse.clicked")
    label_toggle
    ;;
  "routine" | "forced" | "power_source_change")
    render_item
    ;;
  esac
''
