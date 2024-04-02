{ pkgs, lib, config, ... }:
with config.colorscheme.palette;
let
  cfg = config.services.darwin.yabai;
in {
  options.services.darwin.yabai = {
    enable = lib.mkEnableOption "Enables yabai and configuration";

    padding = lib.mkOption {
      default = 0;
      type = lib.types.int;
      description = "Padding aroung Yabai windows";
    };
  };

  config = lib.mkIf cfg.enable {
    services.darwin.skhd.enable = true;
    services.darwin.spacebar.enable = true;

    system.defaults.spaces.spans-displays = false;
    security.accessibilityPrograms = [ "${pkgs.yabai}/bin/yabai" ];

    services.darwin.yabai = {
      padding = 10;
    };

    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = false;
      config = {
        status_bar = "on";
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";

        window_placement = "second_child";
        window_topmost = "on";
        window_shadow = "off";

        window_border = "on";
        window_border_placement = "inset";
        window_border_width = 2;

        active_window_border_color = "0xff${base0C}";
        normal_window_border_color = "0xff${base0D}";
        insert_window_border_color = "0xff${base0E}";

        active_window_opacity = 1.0;
        normal_window_opacity = 0.8;
        window_border_blur = "off";

        layout = "bsp";
        auto_balance = "off";
        split_ratio = 0.5;

        top_padding = cfg.padding;
        right_padding = cfg.padding;
        bottom_padding = cfg.padding;
        left_padding = cfg.padding;
        window_gap = cfg.padding;

        mouse_modifier = "alt";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
      };
      extraConfig = ''
        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
        yabai -m rule --add app="^Find My+ Installer$" manage=off
        yabai -m rule --add app="^Logi Options+$" manage=off
        yabai -m rule --add app="^Logi Options+ Installer$" manage=off
      '';
    };
  };
}
