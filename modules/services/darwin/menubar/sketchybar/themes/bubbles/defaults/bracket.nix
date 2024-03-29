{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "bracketDefaults.sh" ''
  bracket_defaults=(
    background.height=${toString cfg.bracket.background.height}
    background.color=${cfg.bracket.background.color}
    blur_radius=${toString cfg.bracket.blur-radius}
    background.corner_radius=${toString cfg.bracket.background.corner-radius}
  )
''