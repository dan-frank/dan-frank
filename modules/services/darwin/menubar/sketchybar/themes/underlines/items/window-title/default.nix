{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) makeFont;
in pkgs.writeShellScript "window-title.sh" ''
  sketchybar --add      event        window_focus                                    \
            --add       event        title_change                                    \
            --add       item         window_title left                               \
            --set       window_title script="${script}"                              \
                                      label.font="${makeFont cfg.font}"              \
                                      label.y_offset=2                               \
                                      label.padding_left=-0                          \
                                      label.color=0xffd5d9dd                         \
            --subscribe window_title  app_name                                       \
                                      mouse.clicked                                  \
                                      space_change                                   \
                                      front_app_switched                             \
                                      window_focus                                   \
                                      title_change
''
