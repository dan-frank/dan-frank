{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) getColor onOff;
in pkgs.writeShellScript "menuItemDefaults.sh" ''
  menu_item_defaults=(
    label.font="${cfg.font.family}:Regular:13"
    padding_left=${toString cfg.menuItem.padding}
    padding_right=${toString cfg.menuItem.padding}
    icon.padding_left=${toString cfg.menuItem.icon.padding}
    icon.color=${cfg.menuItem.icon.color}
    background.color=${cfg.menuItem.background.color}
    scroll_texts=${onOff cfg.menuItem.scroll-texts}
  )
''