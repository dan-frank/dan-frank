{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  colors = import ./../../colors.nix { inherit pkgs config; };
  icons = import ./../../icons.nix { inherit pkgs; };

  app-space = import ./app-space.nix { inherit pkgs config; };
in pkgs.writeShellScript "spaces.sh" ''
  source ${colors}
  source ${icons}

  # Defaults
  spaces=(
    background.height=16
    background.corner_radius=50
    icon.padding_left=2
    icon.padding_right=2
    label.padding_right=4
  )

  # Get all spaces
  SPACES=($(yabai -m query --spaces | jq -r '.[].index'))

  for SID in "''${SPACES[@]}"; do
    sketchybar --add space space.$SID left   \
      --set space.$SID "''${spaces[@]}"      \
      script="${app-space} $SID"             \
      associated_space=$SID                  \
      icon="$SID"                              \
      --subscribe space.$SID mouse.clicked front_app_switched space_change update_yabai_icon space_windows_change
  done
''
