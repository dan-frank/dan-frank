{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  defaults = import ./../../defaults { inherit pkgs config; };
  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "messages.sh" ''
  source ${defaults.notification}

  messages=(
    "''${notification_defaults[@]}"
    icon=􀌤
    background.color=${getColor { color ="green"; }}
    script="${script}"
    click_script="open -a /System/Applications/Messages.app"
  )

  sketchybar --add item  messages right            \
            --set       messages "''${messages[@]}" \
            --subscribe messages front_app_switched
''
