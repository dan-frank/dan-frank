{ pkgs, config, ...  }:
{ name }:
let
  cfg = config.services.darwin.sketchybar;
in pkgs.writeShellScript "separator.sh" ''
  sketchybar --add item         ${name} left                                         \
             --set ${name}      icon=┃                                               \
                                label.font="${cfg.font.family}:Regular:9.0"          \
                                background.padding_left=-1                           \
                                background.padding_right=-1                          \
                                icon.y_offset=1                                      \
                                label.drawing=off                                    \
                                icon.color=0xff606060
''
