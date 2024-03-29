{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  defaults = import ./../../defaults { inherit pkgs config; };
  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "countdown.sh" ''
  source ${defaults.bracket}

  sketchybar                                          \
    --add item countdown q                            \
    --set countdown script="${script}" \
    "''${bracket_defaults[@]}"                          \
    update_freq=300                                   \
    updates=on                                        \
    icon=􀦛                                            \
    label.font.style="Bold"                           \
    background.color=${getColor { color = "green"; }}                           \
    background.border_width=1                         \
    background.border_color=${getColor { color = "grey"; opacity = "o50"; }}                 \
    label.color=${getColor { color = "grey"; }}                            \
    icon.color=${getColor { color = "grey"; }}
''
