{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs config; };
in pkgs.writeShellScript "diskmonitor.sh" ''
  diskmonitor=(
    icon.font="${cfg.font.family}:Regular:${toString cfg.font.size}"
    icon.padding_right=0
    label.drawing=off
    y_offset=1
    update_freq=300
    updates=when_shown
    script="${script}"
  )

  misc=(
    icon.drawing=off
    width=0
    padding_right=4
    update_freq=300
    updates=when_shown
    label.drawing=off
  )

  diskmonitor_label=(
    "''${misc[@]}"
    label.font="${cfg.font.family}:Semibold:${toString (cfg.font.size / 2.5)}"
    label=SSD
    y_offset=5
  )

  diskmonitor_value=(
    "''${misc[@]}"
    label.font="${cfg.font.family}:Bold:${toString (cfg.font.size / 1.5)}"
    y_offset=-3
  )

  sketchybar                                          \
    --add item diskmonitor.label right                \
    --set diskmonitor.label "''${diskmonitor_label[@]}" \
                                                      \
    --add item diskmonitor.value right                \
    --set diskmonitor.value "''${diskmonitor_value[@]}" \
                                                      \
    --add item diskmonitor right                      \
    --set diskmonitor "''${diskmonitor[@]}"             \
    --subscribe diskmonitor mouse.clicked
''
