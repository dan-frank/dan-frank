{ pkgs, config, ... }:
let
  cfg = config.services.darwin.sketchybar;

  helpers = import ./../helpers { inherit pkgs config; };
  inherit (helpers) getColor makeFont onOff onOffOrString;
in pkgs.writeShellScript "notificationDefaults.sh" ''
  notification_defaults=(
    drawing=${onOff cfg.notification.drawing}
    update_freq=${toString cfg.notification.update-frequency}
    updates=${onOff cfg.notification.updates}
    background.color="${cfg.notification.background.color}"
    background.height=${toString cfg.notification.background.height}
    background.corner_radius=${toString cfg.notification.background.corner-radius}
    icon.font.size=10
    icon.padding_left=${toString cfg.notification.icon.padding}
    icon.padding_right=0
    icon.color="${cfg.notification.icon.color}"
    label.color="${cfg.notification.label.color}"
    label.padding_right=${toString cfg.notification.label.padding}
    label.font.size=11
    label.font.style=Bold
  )
''