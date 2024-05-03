{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "operating-system.sh" ''
  sketchybar --add item ver right                                                   \
            --set ver   update_freq=6400                                            \
                        icon.font="Font Awesome 6 Brands:Regular:12.4"              \
                        icon.padding_right=4                                        \
                        icon.color=${getColor { color = "blue"; }}                  \
                        icon.y_offset=1                                             \
                        label.y_offset=1                                            \
                        label.font="${makeFont cfg.font}"                           \
                        label.color=${getColor { color = "blue"; }}                 \
                        label.padding_right=8                                       \
                        background.color=${getColor { color = "blue"; }}            \
                        background.height=2                                         \
                        background.y_offset=-9                                      \
                        background.padding_right=8                                  \
                        script="${script}"                                          \
                        icon.padding_left=-1 label.padding_right=2                  \
''
