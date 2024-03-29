{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  colors = import ./../../colors.nix { inherit pkgs config; };
  icons = import ./../../icons.nix { inherit pkgs; };

  app-icon = import ./app-icon.nix { inherit pkgs; };
in pkgs.writeShellScript "app-space.sh" ''
  source ${icons}

  SID="$1"
  DEBUG=0

  create_icons() {
    sketchybar --set space."$1" label="$(create_label "$1")"
  }

  update_icons() {
    debug $FUNCNAME

    CURRENT_SID=$(yabai -m query --spaces --space | jq -r '.index')

    if [[ "$CURRENT_SID" == "$SID" ]]; then
      BACKGROUND_COLOR=$HIGHLIGHT_25
      PADDING=${toString cfg.item.background.padding}
      create_icons "$CURRENT_SID"
    else
      BACKGROUND_COLOR=$TRANSPARENT
      PADDING=0
    fi

    sketchybar --animate tanh 10                                     \
              --set space.$SID icon.highlight="$SELECTED"            \
                                label.highlight="$SELECTED"          \
                                background.color="$BACKGROUND_COLOR" \
                                icon.padding_left=${toString cfg.item.background.padding}         \
                                label.padding_right=${toString cfg.item.background.padding}
  }

  create_label() {
    SID=$1
    QUERY=$(yabai -m query --windows --space "$SID")
    IFS=$'\n'
    local APPS
    local CURRENT_APP
    local LABEL BADGE

    APPS=($(echo "$QUERY" | jq -r '.[].app' | sort -u))
    CURRENT_APP=$(echo "$QUERY" | jq -r '.[] | select(.["has-focus"] == true) | .app')

    for APP in "''${APPS[@]}"; do
      # Add icon
      LABEL+=$("${app-icon}" "$APP")
      # Set up badge
      BADGE="$(set_badge $APP)"
      # Add app name for currently focused app
      if [[ "$APP" == "$CURRENT_APP" ]]; then
        LABEL+=" $APP"
      # For unfocused apps…
      else
        # Add a space if there is a badge
        if [[ $BADGE ]]; then
          LABEL+=" "
        fi
      fi
      # Add badge
      LABEL+="$BADGE"
      # Add a space between labels if there is more than one app on a space
      if (( ''${#APPS[@]} > 1 )); then
        LABEL+=" "
      fi
    done

    echo $LABEL

    unset IFS
  }

  set_badge() {
    if [[ "$1" == "Messages" ]]; then
      BADGE=$(sqlite3 ~/Library/Messages/chat.db "SELECT COUNT(guid) FROM message WHERE NOT(is_read) AND NOT(is_from_me) AND text !=${"''"}")
    else
      BADGE=$(lsappinfo -all info -only StatusLabel "$APP" | sed -nr 's/\"StatusLabel\"=\{ \"label\"=\"(.+)\" \}$/\1/p')
    fi

    if [[ ! "$BADGE" ]]; then
      echo ""
    elif [[ ! "$BADGE" =~ ^[0-9]+$ ]]; then
      echo "􀍡"
    elif (( $BADGE < 10 )); then
      ICONS=("" 􀀺 􀀼 􀀾 􀁀 􀁂 􀁄 􀁆 􀁈 􀁊)
      echo "''${ICONS[$BADGE]}"
    else
      echo "􀍡"
    fi
  }

  mouse_clicked() {
    if [[ "$BUTTON" == "right" ]] || [[ "$MODIFIER" == "shift" ]]; then
      SPACE_NAME="''${NAME#*.}"
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Rename space $SPACE_NAME to:\" default answer \"\" with title \"Space Renamer\" buttons {\"Cancel\", \"Rename\"} default button \"Rename\"))")"
      if [[ $? -eq 0 ]]; then
        if [[ "$SPACE_LABEL" == "" ]]; then
          set_space_label "''${NAME:6}"
        else
          set_space_label "''${NAME:6} $SPACE_LABEL"
        fi
      fi
    elif [[ "$MODIFIER" == "cmd" ]]; then
      yabai -m query --spaces --space |
        jq -re ".index" |
        xargs -I{} yabai -m query --windows --space {} |
        jq -sre 'add | map(select(."is-minimized"==false)) | sort_by(.display, .frame.y, .frame.x, .id) | . as $array | length as $array_length | index(map(select(."has-focus"==true))) as $has_index | if $has_index > 0 then nth($has_index - 1).id else nth($array_length - 1).id end' |
        xargs -I{} yabai -m window --focus {}
    else
      yabai -m space --focus "$SID"
    fi
  }

  set_space_label() {
    sketchybar --set "$NAME" icon="$@"
  }

  debug() {
    if (( DEBUG == 1 )); then
      echo ---$(date +"%T")---
      echo sender: "$SENDER"
      echo sid: "$SID"
      echo ---
      echo $@
      echo ---
    fi
  }

  case "$SENDER" in
  "routine" | "forced" | "space_windows_change")
    create_icons "$SID"
    ;;
  "front_app_switched" | "space_change")
    update_icons
    ;;
  "mouse.clicked")
    mouse_clicked
    ;;
  esac
''
