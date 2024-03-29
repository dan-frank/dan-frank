{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "separatorDefaults.sh" ''
  separator=(
    background.height=${toString cfg.separator.background.height}
    width=${toString cfg.separator.width}
    background.color="${cfg.separator.background.color}"
    background.y_offset=${toString cfg.separator.background.y-offset}
  )
''