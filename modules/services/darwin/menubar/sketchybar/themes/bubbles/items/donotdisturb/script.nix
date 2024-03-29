{ pkgs, config, ...  }:
let
  colors = import ./../../colors.nix { inherit pkgs config; };
  icons = import ./../../icons.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "donotdisturb-script.sh" ''
  source ${colors}
  source ${icons}

  check_state() {
    # DND_ENABLED=$(cat ~/Library/DoNotDisturb/DB/Assertions.json | jq .data[0].storeAssertionRecords)

    # Alternate SLOW method:
    DND_ENABLED=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")

    if [ "$DND_ENABLED" -eq 0 ]; then
      COLOR=${getColor { color ="white"; opacity = "o25"; }}
    else
      COLOR=${getColor { color ="white"; }}
    fi

    sketchybar --set "$NAME" icon.color="$COLOR"
  }

  update_icon() {
    if [ "$SENDER" == "focus_off" ]; then
      COLOR=${getColor { color ="white"; opacity = "o25"; }}
    else
      COLOR=${getColor { color ="white"; }}
    fi

    sketchybar --set "$NAME" icon.color="$COLOR"
  }

  toggle_dnd() {
    osascript -e 'tell application "System Events" to keystroke "\\" using {control down, shift down, command down, option down}'
  }

  case "$SENDER" in
  "routine" | "forced")
    check_state
    ;;
  "focus_on" | "focus_off")
    update_icon
    ;;
  "mouse.clicked")
    toggle_dnd
    ;;
  esac
''
