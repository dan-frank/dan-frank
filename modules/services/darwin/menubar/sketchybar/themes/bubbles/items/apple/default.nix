{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  nextEvent = import ./nextEvent.nix { inherit pkgs; };

  defaults = import ./../../defaults { inherit pkgs config; };
  menuItemDefaults = import ./../../defaults/menuItem.nix { inherit pkgs config; };

  scripts = import ./../../../../scripts { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "apple.sh" ''
  source ${defaults.menu}
  source ${defaults.menuItem}
  source ${defaults.separator}

  POPUP_OFF='${builtins.readFile scripts.popupOff}'

  logo=(
    "''${menu_defaults[@]}"
    icon=􀣺
    icon.font="${cfg.font.family}:Black:${toString cfg.font.size}"
    label.drawing=off
    popup.align=left
    click_script="sketchybar --set logo popup.drawing=toggle"
    --subscribe logo mouse.exited
                    mouse.exited.global
  )

  logo_about=(
    "''${menu_item_defaults[@]}"
    icon=􀅴
    label="About This Mac"
    click_script="open x-apple.systempreferences:com.apple.SystemProfiler.AboutExtension; $POPUP_OFF"
    "''${separator[@]}"
  )

  logo_settings=(
    "''${menu_item_defaults[@]}"
    icon=􀍟
    label="System Settings"
    click_script="open -a 'System Settings'; $POPUP_OFF"
  )

  logo_sleep=(
    "''${menu_item_defaults[@]}"
    icon=􀜚
    label="Sleep"
    click_script="pmset sleepnow; $POPUP_OFF"
  )

  logo_restart=(
    "''${menu_item_defaults[@]}"
    icon=􀣨
    label="Restart…"
    click_script="osascript -e 'tell app \"loginwindow\" to «event aevtrrst»'; $POPUP_OFF"
  )

  logo_shutdown=(
    "''${menu_item_defaults[@]}"
    icon=􀷃
    label="Shut Down…"
    click_script="osascript -e 'tell app \"loginwindow\" to «event aevtrsdn»'; $POPUP_OFF"
  )

  logo_lockscreen=(
    "''${menu_item_defaults[@]}"
    icon=􀼑
    label="Lock Screen    􀆍􀆔Q"
    click_script="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'; $POPUP_OFF"
  )

  logo_logout=(
    "''${menu_item_defaults[@]}"
    icon=􀉭
    label="Log Out ''${USER}… 􀆝􀆔Q"
    click_script="osascript -e 'tell app \"System Events\" to log out'; $POPUP_OFF"
    "''${separator[@]}"
  )

  logo_refresh=(
    "''${menu_item_defaults[@]}"
    icon=􀅈
    label="Refresh Sketchybar"
    click_script="$POPUP_OFF; sketchybar --update"
  )

  sketchybar                                            \
    --add item logo left                                \
    --set logo "''${logo[@]}"                             \
                                                        \
    --add item logo.about popup.logo                    \
    --set      logo.about "''${logo_about[@]}"            \
                                                        \
    --add item logo.settings popup.logo                 \
    --set      logo.settings "''${logo_settings[@]}"      \
                                                        \
    --add item logo.sleep popup.logo                    \
    --set      logo.sleep "''${logo_sleep[@]}"            \
                                                        \
    --add item logo.restart popup.logo                  \
    --set      logo.restart "''${logo_restart[@]}"        \
                                                        \
    --add item logo.shut_down popup.logo                \
    --set      logo.shut_down "''${logo_shutdown[@]}"     \
                                                        \
    --add item logo.lock_screen popup.logo              \
    --set      logo.lock_screen "''${logo_lockscreen[@]}" \
                                                        \
    --add item logo.logout popup.logo                   \
    --set      logo.logout "''${logo_logout[@]}"          \
                                                        \
    --add item logo.refresh popup.logo                  \
    --set      logo.refresh "''${logo_refresh[@]}"
''
