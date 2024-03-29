{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) makeFont onOff onOffOrString;
in pkgs.writeShellScript "itemDefaults.sh" ''
  item_defaults=(
    background.padding_left=${toString cfg.item.background.padding}
    background.padding_right=${toString cfg.item.background.padding}
    icon.padding_left=${toString cfg.item.icon.padding}
    icon.padding_right=${toString cfg.item.icon.padding}
    icon.background.corner_radius=${toString cfg.item.icon.background.corner-radius}
    icon.background.height=${toString cfg.item.icon.background.height}
    icon.font="${makeFont cfg.font}"
    icon.color=${cfg.item.icon.color}
    icon.highlight_color=${cfg.item.icon.highlight-color}
    label.font="${makeFont cfg.font}"
    label.color=${cfg.item.label.color}
    label.highlight_color=${cfg.item.label.highlight-color}
    label.padding_left=${toString cfg.item.label.padding}
    updates=when_shown
    scroll_texts=${onOff cfg.item.scroll-texts}
  )
''