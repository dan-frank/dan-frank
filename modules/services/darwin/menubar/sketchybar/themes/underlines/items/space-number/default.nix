{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs; };

  helpers = import ./../../helpers { inherit pkgs config; };
  inherit (helpers) makeFont;
in pkgs.writeShellScript "space-number.sh" ''
  sketchybar \
    --add item space-number left \
    --set space-number script='${script}'\
    --subscribe space-number space_change
''
