{ pkgs, lib, config, ... }:
{
  options = {
    yabai.enable = lib.mkEnableOption "Enables yabai and configuration";
  };

  config = lib.mkIf config.yabai.enable {
    skhd.enable = true;
    spacebar.enable = true;

    system.defaults.spaces.spans-displays = false;
    security.accessibilityPrograms = [ "${pkgs.yabai}/bin/yabai" ];

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

        active_window_border_color = "0xff6d3ab0";
        normal_window_border_color = "0xff505050";
        insert_window_border_color = "0xffd75f5f";

        active_window_opacity = 1.0;
        normal_window_opacity = 0.8;
        window_border_blur = "off";

        layout = "bsp";
        auto_balance = "off";
        split_ratio = 0.5;

        external_bar = "all:0:36";
        top_padding = 10;
        right_padding = 10;
        bottom_padding = 10;
        left_padding = 10;
        window_gap = 10;

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
