{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "clock.sh" ''
  sketchybar --add item clock right                                                 \
            --set clock update_freq=1                                               \
                        icon=""                                                    \
                        icon.font="Font Awesome 6 Free:Solid:12.4"                  \
                        icon.padding_right=4                                        \
                        icon.color=${getColor { color = "cyan"; }}                  \
                        icon.y_offset=2                                             \
                        label.y_offset=2                                            \
                        label.font="${makeFont cfg.font}"                           \
                        label.color=${getColor { color = "cyan"; }}                 \
                        label.padding_right=8                                       \
                        background.color=${getColor { color = "cyan"; }}            \
                        background.height=2                                         \
                        background.padding_right=6                                  \
                        background.y_offset=-9                                      \
                        script="${script}"                                          \
                        icon.padding_left=0 label.padding_right=1                   \
''
