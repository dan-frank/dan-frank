{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  items = import ./items { inherit pkgs config; };

  helpers = import ./../../helpers { inherit config; };
  inherit (helpers) onOff makeFont;
in pkgs.writeShellScript "sketchybarrc" ''
  bar=(
    color=${cfg.bar.color}
    position=${cfg.bar.position}
    height=${toString cfg.bar.height}
    sticky=${onOff cfg.bar.sticky}
    padding_left=${toString cfg.bar.padding}
    padding_right=${toString cfg.bar.padding}
  )

  default=(
    icon.drawing=off
    label.padding_left=${toString cfg.bar.text.padding}
    label.padding_right=${toString cfg.bar.text.padding}
    label.color=${cfg.bar.text.color}
    label.font="${makeFont cfg.font}"
  )

  sketchybar \
    --bar "''${bar[@]}" \
    --default "''${default[@]}"

  sketchybar \
    --add item space left \
    --set space script='sketchybar --set "$NAME" label="[$(echo "$INFO" | jq .[])]"'\
    --subscribe space space_change

  sketchybar \
    --add item app_name left \
    --set app_name script='sketchybar --set "$NAME" label="$USER::$INFO"' \
    --subscribe app_name front_app_switched

  sketchybar \
    --add item time right \
    --set time script='sketchybar --set "$NAME" label="$(date "+%H:%M")"' \
              update_freq=30 \
    --subscribe time system_woke

  sketchybar \
    --add item date right \
    --set date script='sketchybar --set "$NAME" label="$(date "+%a, %d %b")"' \
              update_freq=60 \
              click_script="open -a Calendar.app" \
    --subscribe date system_woke \
                  mouse.entered \
                  mouse.exited \
                  mouse.exited.global

  sketchybar \
    --add item ip right \
    --set ip script='sketchybar --set "$NAME" label="/$(ipconfig getifaddr en0)/"'\
    --subscribe ip wifi_change

  sketchybar --update
''
