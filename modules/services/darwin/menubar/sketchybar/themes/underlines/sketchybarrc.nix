{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  items = import ./items { inherit pkgs config; };

  icons = import ./icons.nix { inherit pkgs; };

  helpers = import ./helpers { inherit config; };
  inherit (helpers) getColor onOff makeFont;
in pkgs.writeShellScript "sketchybarrc" ''
  #  ___
  # |_ _| |_ __ _ _   _
  #  | || __/ _` | | | |  github:   https://github.com/itaysharir
  #  | || || (_| | |_| |  reddit:   u/visible-pop-2576
  # |___|\__\__,_|\__, |  dotfiles: https://github.com/itaysharir/Dotfiles
  #               |___/   theme:    dt-xmonad

  ### Load icons ###
  source ${icons} # TODO: Is this used?

  ### Setting up the general bar appearance and default values ###
  bar=(
    blur_radius=${toString cfg.bar.blur-radius}
    border_width=${toString cfg.bar.border-width}
    color=${cfg.bar.color}
    corner_radius=${toString cfg.bar.corner-radius}
    font_smoothing=${onOff cfg.bar.font-smoothing}
    height=${toString cfg.bar.height}
    margin=${toString cfg.bar.margin}
    notch_width = ${toString cfg.bar.notch-width}
    padding_left=${toString cfg.bar.padding}
    padding_right=${toString cfg.bar.padding}
    position=${cfg.bar.position}
    sticky=${onOff cfg.bar.sticky}
    topmost=${onOff cfg.bar.topmost}
    y_offset=${toString cfg.bar.y-offset}
  )

  default=(
    background.padding_left=${toString cfg.bar.background.padding}
    background.padding_right=${toString cfg.bar.background.padding}
    drawing=${onOff cfg.bar.drawing}
    icon.color=${cfg.bar.icon.color}
    icon.font="${makeFont cfg.bar.icon.font}"
    icon.padding_left=${toString cfg.bar.icon.padding}
    icon.padding_right=${toString cfg.bar.icon.padding}
    label.color=${cfg.bar.label.color}
    label.font="${makeFont cfg.bar.label.font}"
    label.padding_left=${toString cfg.bar.label.padding}
    label.padding_right=${toString cfg.bar.label.padding}
    updates=when_shown
  )

  sketchybar \
    --bar "''${bar[@]}" \
    --default "''${default[@]}"

  sketchybar --animate sin 30 --bar y_offset=${toString cfg.bar.y-offset} y_offset=0

  ### Left items ###
  source ${items.spaces}
  source ${items.separator { name = "separator-1"; }}
  # source ${items.yabai} # TODO: What is this doing?
  # source ${items.separator { name = "separator-2"; }}
  # source ${items.space-number} # NOTE: Not needed while spaces in current state
  # source ${items.separator { name = "separator-3"; }}
  source ${items.window-title}

  ### Right items ###
  source ${items.clock}
  source ${items.battery}
  source ${items.uptime}
  source ${items.storage}
  source ${items.memory}
  source ${items.processor}
  source ${items.operating-system}

  ### If an update is avalible, update sketchybar when launched ###
  sketchybar --update

  ### Notify when sketchybarrc is finished loading ###
  echo "sketchybar configuation loaded.."
''
