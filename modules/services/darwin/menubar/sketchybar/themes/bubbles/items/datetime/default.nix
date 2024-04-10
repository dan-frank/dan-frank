{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  nextEvent = import ./nextEvent.nix { inherit pkgs; };

  menuDefaults = import ./../../defaults/menu.nix { inherit pkgs config; };
  menuItemDefaults = import ./../../defaults/menuItem.nix { inherit pkgs config; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "datetime.sh" ''
  source ${menuDefaults}
  source ${menuItemDefaults}

  date=(
    icon=􀀁
    icon.drawing=off
    icon.font.size=6
    icon.padding_right=1
    icon.color=${getColor { color = "yellow"; }}
    icon.y_offset=1.5
    label.font="${cfg.font.family}:Semibold:8"
    label.padding_left=0
    label.padding_right=4
    y_offset=5
    width=0
    update_freq=60
    script='sketchybar --set "$NAME" label="$(date "+%a, %d %b")"'
    click_script="open -a Calendar.app"
  )

  clock=(
    "''${menu_defaults[@]}"
    icon.drawing=off
    label.font="${cfg.font.family}:Bold:10"
    label.padding_right=4
    y_offset=-3
    update_freq=10
    popup.align=right
    script="${nextEvent}"
    click_script="sketchybar --set clock popup.drawing=toggle; open -a Calendar.app"
  )

  calendar_item=(
    padding_left=0
    padding_right=0
    label.padding_left=0
    label.padding_right=0
    icon.drawing=off
  )

  sketchybar                                                \
    --add item date right                                   \
    --set date "''${date[@]}"                               \
    --subscribe date system_woke                            \
                    mouse.entered                           \
                    mouse.exited                            \
                    mouse.exited.global                     \
    --add item date.details popup.date                      \
    --set date.details "''${menu_item_defaults[@]}"         \
                                                            \
    --add item clock right                                  \
    --set clock "''${clock[@]}"                             \
    --subscribe clock system_woke                           \
                      mouse.entered                         \
                      mouse.exited                          \
                      mouse.exited.global                   \
    --add item clock.next_event popup.clock                 \
    --set clock.next_event "''${menu_item_defaults[@]}" icon.drawing=off label.padding_left=0 label.max_chars=22 \
''
