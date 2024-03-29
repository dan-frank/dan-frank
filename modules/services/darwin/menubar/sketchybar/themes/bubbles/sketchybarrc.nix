{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  items = import ./items { inherit pkgs config; };

  defaults = import ./defaults { inherit pkgs config; };
in pkgs.writeShellScript "sketchybarrc" ''
  ############## DEFAULTS ##############
  # TODO: Inherit from cfg.defaults
  source ${defaults.bar}
  source ${defaults.bracket}
  source ${defaults.item}

  sketchybar --bar "''${bar[@]}" --default "''${item_defaults[@]}"

  # source the apple logo
  source ${items.apple}
  source ${items.yabai}
  source ${items.spaces}

  # source ${items.countdown}

  source ${items.control-center}
  source ${items.datetime}
  source ${items.donotdisturb}
  source ${items.wifi}
  source ${items.battery}
  source ${items.volume}
  source ${items.diskmonitor}
  source ${items.messages}
  source ${items.weather}
  source ${items.music}

  sketchybar \
          --add bracket left_side logo yabai '/space\..*/' \
          --set left_side "''${bracket_defaults[@]}" \
  \
          --add bracket status_icons weather transmission messages diskmonitor volume_icon volume battery wifi dnd date clock control_center \
          --set status_icons "''${bracket_defaults[@]}"

  sketchybar --hotload on
  sketchybar --update
''
