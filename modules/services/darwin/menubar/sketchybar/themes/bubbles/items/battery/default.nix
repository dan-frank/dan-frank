{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs config; };
in pkgs.writeShellScript "battery.sh" ''
  battery=(
    icon.font.size=16
    icon.padding_right=0
    icon.font.style="Light"
    update_freq=60
    popup.align=right
    script="${script}"
    updates=when_shown
  )

  sketchybar \
    --add item battery right \
    --set battery "''${battery[@]}" \
    --subscribe battery power_source_change \
                        mouse.clicked
''
