{ pkgs, config, ...  }:
let
  cfg = config.services.darwin.sketchybar;

  script = import ./script.nix { inherit pkgs config; };

  defaults = import ./../../defaults { inherit pkgs config; };
in pkgs.writeShellScript "music.sh" ''
  source ${defaults.bracket}
  source ${defaults.menu}

  music=(
    "''${bracket_defaults[@]}"
    script="${script}"
    popup.align=center
    padding_left=0
    label.padding_right=${toString cfg.bar.padding}
    padding_right=${toString (cfg.bar.padding * 2)}
    drawing=off
    label="Loading…"
    background.image=media.artwork
    background.image.scale=0.75
    background.image.corner_radius=${toString cfg.bar.padding}
    icon.padding_left=32
    label.max_chars=33
    updates=on
    --subscribe music media_change
    --subscribe music mouse.entered
                      mouse.clicked
                      mouse.exited
                      mouse.exited.global
  )

  sketchybar                               \
    --add item music right                 \
    --set      music "''${music[@]}"         \
    --set      music "''${menu_defaults[@]}" \
    --add item music.cover popup.music     \
    --add item music.artist popup.music    \
    --add item music.title popup.music     \
    --add item music.album popup.music
''
