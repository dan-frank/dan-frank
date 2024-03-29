{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs config; };

  defaults = import ./../../defaults { inherit pkgs config; };
  scripts = import ./../../../../scripts { inherit pkgs; };
in pkgs.writeShellScript "wifi.sh" ''
  source ${defaults.menu}
  source ${defaults.menuItem}

  wifi=(
    "''${menu_defaults[@]}"
    script="${script}"
    click_script="${scripts.popupClickScript}"
    label.drawing=off
    popup.align=right
    update_freq=5
    --subscribe wifi wifi_change
                    mouse.entered
                    mouse.exited
                    mouse.exited.global
  )

  sketchybar                                                                                            \
    --add item wifi right                                                                               \
    --set wifi "''${wifi[@]}"                                                                             \
    --add item wifi.ssid popup.wifi                                                                     \
    --set wifi.ssid icon=􀅴                                                                              \
          label="SSID"                                                                                  \
          "''${menu_item_defaults[@]}"                                                                    \
          click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';${scripts.popupOff}" \
    --add item wifi.strength popup.wifi                                                                 \
    --set wifi.strength icon=􀋨                                                                          \
          label="Speed"                                                                                 \
          "''${menu_item_defaults[@]}"                                                                    \
          click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';${scripts.popupOff}" \
    --add item wifi.ipaddress popup.wifi                                                                \
    --set wifi.ipaddress icon=􀆪                                                                         \
          label="IP Address"                                                                            \
          "''${menu_item_defaults[@]}"                                                                    \
          click_script="echo \"$IP_ADDRESS\"|pbcopy;${scripts.popupOff}"
''
