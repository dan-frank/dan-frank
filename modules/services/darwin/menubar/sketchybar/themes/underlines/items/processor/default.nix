{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "processor.sh" ''
  sketchybar --add item cpu right                                                   \
            --set cpu   update_freq=10                                              \
                        icon.font="Font Awesome 6 Free:Solid:12.4"                  \
                        icon.padding_right=4                                        \
                        icon.color=${getColor { color = "yellow"; }}                \
                        icon.y_offset=1                                             \
                        label.y_offset=1                                            \
                        label.font="${makeFont cfg.font}"                           \
                        label.color=${getColor { color = "yellow"; }}               \
                        label.padding_right=8                                       \
                        background.color=${getColor { color = "yellow"; }}          \
                        background.height=2                                         \
                        background.y_offset=-9                                      \
                        background.padding_right=8                                  \
                        script="${script}"                                          \
                        icon.padding_left=0 label.padding_right=2                   \
''
