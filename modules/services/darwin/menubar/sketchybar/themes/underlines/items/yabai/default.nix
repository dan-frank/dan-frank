{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs config; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "yabai.sh" ''
  sketchybar --add       event          window_focus                                 \
            --add       item           system.yabai left                             \
            --set       system.yabai   script="${script}"                            \
                                        icon.font="${makeFont cfg.font}"             \
                                        label.drawing=off                            \
                                        icon.color=${getColor { color = "green"; }}  \
                                        icon.y_offset=2                              \
                                        icon.padding_left=8                          \
                                        updates=on                                   \
            --subscribe system.yabai window_focus mouse.clicked
''
