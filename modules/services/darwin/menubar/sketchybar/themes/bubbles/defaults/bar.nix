{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) onOff onOffOrString;
in pkgs.writeShellScript "barDefaults.sh" ''
  bar=(
    color=${cfg.bar.color}
    border_color=${cfg.bar.border-color}
    position=${cfg.bar.position}
    height=${toString cfg.bar.height}
    margin=${toString cfg.bar.margin}
    y_offset=${toString cfg.bar.y-offset}
    corner_radius=${toString cfg.bar.corner-radius}
    border_width=${toString cfg.bar.border-width}
    blur_radius=${toString cfg.bar.blur-radius}
    padding_left=${toString cfg.bar.padding}
    padding_right=${toString cfg.bar.padding}
    notch_width=${toString cfg.bar.notch-width}
    notch_offset=${toString cfg.bar.notch-offset}
    display=${cfg.bar.display}
    hidden=${onOffOrString cfg.bar.hidden}
    topmost=${onOffOrString cfg.bar.topmost}
    sticky=${onOff cfg.bar.sticky}
    font_smoothing=${onOff cfg.bar.font-smoothing}
    shadow=${onOff cfg.bar.shadow}
  )
''