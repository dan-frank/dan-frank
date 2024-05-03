{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "storage.sh" ''
  sketchybar --add item ssd right                                                   \
            --set ssd   update_freq=10                                              \
                        icon.font="Font Awesome 6 Free:Solid:13.3"                  \
                        icon.padding_right=4                                        \
                        icon.color=${getColor { color = "magenta"; }}               \
                        icon.y_offset=1                                             \
                        label.y_offset=1                                            \
                        label.font="${makeFont cfg.font}"                           \
                        label.color=${getColor { color = "magenta"; }}              \
                        label.padding_right=8                                       \
                        background.color=${getColor { color = "magenta"; }}         \
                        background.height=2                                         \
                        background.y_offset=-9                                      \
                        background.padding_right=8                                  \
                        script="${script}"                                          \
                        icon.padding_left=0 label.padding_right=2                   \
''
