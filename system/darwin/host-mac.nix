{ config, pkgs, ... }:
let
  cfg = config.system;
in {
  # Copy applications into ~/Applications/Nix Apps. This workaround allows us
  # to find applications installed by nix through spotlight.
  # system.activationScripts.applications.text = pkgs.lib.mkForce (
  #   ''
  #     if [[ -L "$HOME/Applications" ]]; then
  #       rm "$HOME/Applications"
  #       mkdir -p "$HOME/Applications/Nix Apps"
  #     fi

  #     rm -rf "$HOME/Applications/Nix Apps"
  #     mkdir -p "$HOME/Applications/Nix Apps"

  #     for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
  #       src="$(/usr/bin/stat -f%Y "$app")"
  #       echo "copying $app"
  #       cp -rL "$src" "$HOME/Applications/Nix Apps"
  #     done
  #   ''
  # );

  system.defaults.spaces.spans-displays = false;
  security.accessibilityPrograms = [ "${pkgs.yabai}/bin/yabai" ];
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      status_bar = "on";
      mouse_follows_focus = "on";
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
      normal_window_opacity = 0.5;

      layout = "bsp";
      auto_balance = "off";
      split_ratio = 0.5;

      top_padding = 10;
      bottom_padding = 46;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;

      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig = ''
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add app="^Calculator$" manage=off
    '';
  };

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      display                    = "all";
      position                   = "bottom";
      height                     = 36;
      padding_left               = 20;
      padding_right              = 20;
      spacing_left               = 25;
      spacing_right              = 16;
      background_color           = "0xff24292e";
      foreground_color           = "0xffa8a8a8";
      text_font                  = ''"Hack:Regular:12.0"'';
      icon_font                  = ''"Hack:Regular:12.0"'';
      title                      = "on";
      display_separator          = "on";
      display_separator_icon     = "";
      spaces                     = "on";
      spaces_for_all_displays    = "on";
      space_icon                 = "•";
      space_icon_strip           = "I II III IV V VI VII VIII IX X";
      space_icon_color           = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary  = "0xfffff9b0";
      right_shell                = "off";
      right_shell_icon           = "";
      right_shell_command        = "whoami";
      battery_icon_color         = "0xfff97583";
      power                      = "on";
      power_icon_color           = "0xff85e89d";
      power_icon_strip           = " ";
      dnd                        = "on";
      dnd_icon                   = "";
      dnd_icon_color             = "0xffe0e2e4";
      clock                      = "on";
      clock_icon                 = "";
      clock_format               = ''"%d/%m/%y %R"'';
      clock_icon_color           = "0xffe0e2e4";
    };
  };
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  services.spacebar.config.debug_output = "on";
  launchd.user.agents.spacebar.serviceConfig.StandardErrorPath = "/tmp/spacebar.err.log";
  launchd.user.agents.spacebar.serviceConfig.StandardOutPath = "/tmp/spacebar.out.log";
}
