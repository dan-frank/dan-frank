{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont;
in pkgs.writeShellScript "uptime.sh" ''
  sketchybar --add item uptime right                                                 \
            --set uptime update_freq=120                                            \
                        icon.font="Font Awesome 6 Free:Solid:12.4"                  \
                        icon.padding_right=4                                        \
                        icon.color=${getColor { color = "green"; }}                 \
                        label.y_offset=1                                            \
                        icon.y_offset=1                                             \
                        label.font="${makeFont cfg.font}"                           \
                        label.color=${getColor { color = "green"; }}                \
                        label.padding_right=4                                       \
                        background.color=${getColor { color = "green"; }}           \
                        background.height=2                                         \
                        background.y_offset=-9                                      \
                        background.padding_right=8                                  \
                        script="${script}"                                          \
                        icon.padding_left=0 label.padding_right=2                   \
''
