{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  space-highlight = import ./space-highlight.nix { inherit pkgs; };
  space-click = import ./space-click.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) makeFont getColor;
in pkgs.writeShellScript "spaces.sh" ''
  spaces=(
    background.padding_left=0
    background.padding_right=1
    drawing=on
    icon.background.color=${getColor { color = "icon-color"; }}
    icon.background.height=2
    icon.background.y_offset=-10
    icon.color=${getColor { color = "icon-color"; }}
    icon.font="${makeFont cfg.font}"
    icon.highlight_color=${getColor { color = "icon-color"; }}
    icon.padding_right=${toString cfg.bar.icon.padding}
    icon.padding_left=${toString cfg.bar.icon.padding}
    icon.y_offset=2
    label.drawing=off
    label.font="${makeFont cfg.font}"
    updates=on
    ignore_association=on
  )

  SPACES=($(yabai -m query --spaces | jq -r '.[].index'))
  for SID in "''${SPACES[@]}"; do
    sketchybar  --add space space.$SID  left                          \
                --set space.$SID        "''${SPACES[@]}"              \
                                        click_script="${space-click}" \
                                        script="${space-highlight}"   \
                                        associated_space=$SID         \
                                        icon=$SID                     \
                --subscribe space.$SID  mouse.clicked                 \
                                        front_app_switched            \
                                        space_change                  \
                                        update_yabai_icon             \
                                        space_windows_change
  done
''
