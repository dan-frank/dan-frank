{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  icons = import ./../../icons.nix { inherit pkgs; };

  volume = import ./volume.nix { inherit pkgs; };
  volume-click = import ./volume-click.nix { inherit pkgs config; };

  menuDefaults = import ./../../defaults/menu.nix { inherit pkgs config; };
  menuItemDefaults = import ./../../defaults/menuItem.nix { inherit pkgs config; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "volume.sh" ''
  source ${icons}

  source ${menuDefaults}
  source ${menuItemDefaults}

  volume_slider=(
    script="${volume}"
    updates=on
    label.drawing=off
    icon.drawing=off
    slider.highlight_color=${cfg.item.label.highlight-color}
    slider.background.height=8
    slider.background.corner_radius=12
    slider.background.color=${getColor { color = "white"; opacity = "o25"; }}
    padding_left=0
    padding_right=0
  )

  volume_icon=(
    click_script="${volume-click}"
    icon=$VOLUME_100
    icon.font="${cfg.font.family}:Regular:14.0"
    label.drawing=off
  )

  sketchybar --add slider volume right              \
            --set volume "''${volume_slider[@]}"     \
            --subscribe volume volume_change       \
                                mouse.clicked       \
                                mouse.entered       \
                                mouse.exited        \
                                mouse.exited.global \
                                                    \
            --add item volume_icon right           \
            --set volume_icon "''${volume_icon[@]}"
''
