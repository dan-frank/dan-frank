{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) onOff;
in pkgs.writeShellScript "menuDefaults.sh" ''
  menu_defaults=(
    popup.blur_radius=${toString cfg.menu.blur-radius}
    popup.background.color=${cfg.menu.background.color}
    popup.background.padding_left=40
    popup.background.padding_right=40
    popup.background.corner_radius=${toString cfg.menu.background.corner-radius}
    popup.background.shadow.drawing=${onOff cfg.menu.background.shadow.drawing}
    popup.background.shadow.color=${cfg.menu.background.shadow.color}
    popup.background.shadow.angle=${toString cfg.menu.background.shadow.angle}
    popup.background.shadow.distance=${toString cfg.menu.background.shadow.distance}
  )
''