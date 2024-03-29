{ pkgs, config, ...  }:
let
  colors = import ./../../colors.nix { inherit pkgs config; };
  scripts = import ./../../../../scripts { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "wifi-script.sh" ''
  source ${colors}

  IS_VPN=$(/usr/local/bin/piactl get connectionstate)
  # IS_VPN="Disconnected"
  CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
  IP_ADDRESS="$(ipconfig getifaddr en0)"
  SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
  CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

  if [[ $IS_VPN != "Disconnected" ]]; then
    ICON_COLOR=$HIGHLIGHT
    ICON=􀎡
  elif [[ $SSID = "Ebrietas" ]]; then
    ICON_COLOR=${getColor { color ="white"; }}
    ICON=􀉤
  elif [[ $SSID != "" ]]; then
    ICON_COLOR=${getColor { color ="white"; }}
    ICON=􀐿
  elif [[ $CURRENT_WIFI = "AirPort: Off" ]]; then
    ICON=􀐾
  else
    ICON_COLOR=${getColor { color ="white"; opacity = "o25"; }}
    ICON=􀐾
  fi

  render_bar_item() {
    sketchybar --set "$NAME" \
      icon.color="$ICON_COLOR" \
      icon="$ICON" \
      click_script="${scripts.popupClickScript}"
  }

  render_popup() {
    if [ "$SSID" != "" ]; then
      args=(
        --set wifi click_script="${scripts.popupClickScript}"
        --set wifi.ssid label="$SSID"
        --set wifi.strength label="$CURR_TX Mbps"
        --set wifi.ipaddress label="$IP_ADDRESS"
        click_script="printf $IP_ADDRESS | pbcopy;${scripts.popupOff}"
      )
    else
      args=(
        --set wifi click_script="")
    fi

    sketchybar "''${args[@]}" >/dev/null
  }

  update() {
    render_bar_item
    render_popup
  }

  popup() {
    sketchybar --set "$NAME" popup.drawing="$1"
  }

  case "$SENDER" in
  "routine" | "forced")
    update
    ;;
  "mouse.entered")
    popup on
    ;;
  "mouse.exited" | "mouse.exited.global")
    popup off
    ;;
  "mouse.clicked")
    popup toggle
    ;;
  esac

  # click_script="sketchybar --set wifi.alias popup.drawing=toggle; $WIFI_CLICK_SCRIPT" \
''
