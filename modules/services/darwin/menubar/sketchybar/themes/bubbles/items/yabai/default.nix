{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  icons = import ./../../icons.nix { inherit pkgs; };

  script = import ./script.nix { inherit pkgs config; };
in pkgs.writeShellScript "yabai.sh" ''
  source ${icons}

  yabai=(
    icon=$YABAI_GRID
    label.drawing=off
    script="${script}"
    icon.font="${cfg.font.family}:Bold:${toString cfg.font.size}"
  )

  sketchybar --add event update_yabai_icon

  sketchybar --add item yabai left                   \
            --set yabai "''${yabai[@]}"               \
            --subscribe yabai space_change          \
                              mouse.scrolled.global \
                              mouse.clicked         \
                              front_app_switched    \
                              space_windows_change  \
                              alfred_trigger        \
                              update_yabai_icon
''