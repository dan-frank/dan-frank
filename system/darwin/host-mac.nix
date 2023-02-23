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

    services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # -- Notes --
      # See https://github.com/josean-dev/dev-environment-files/blob/main/.config/skhd/skhdrc

      # -- Changing Window Focus --

      # change window focus within space
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east

      #change focus between external displays (left and right)
      alt - s: yabai -m display --focus west
      alt - g: yabai -m display --focus east

      # -- Modifying the Layout --

      # rotate layout clockwise
      shift + alt - r : yabai -m space --rotate 270

      # mirror along on X and Y Axis
      shift + alt - x : yabai -m space --mirror x-axis
      shift + alt - y : yabai -m space --mirror y-axis

      # toggle window float
      shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2


      # -- Modifying Window Size --

      # maximize a window
      shift + alt - m : yabai -m window --toggle zoom-fullscreen

      # balance out tree of windows (resize to occupy same area)
      shift + alt - e : yabai -m space --balance

      # -- Moving Windows Around --

      # swap windows
      shift + alt - j : yabai -m window --swap south
      shift + alt - k : yabai -m window --swap north
      shift + alt - h : yabai -m window --swap west
      shift + alt - l : yabai -m window --swap east

      # move window and split
      ctrl + alt - j : yabai -m window --warp south
      ctrl + alt - k : yabai -m window --warp north
      ctrl + alt - h : yabai -m window --warp west
      ctrl + alt - l : yabai -m window --warp east

      # move window to display left and right
      shift + alt - s : yabai -m window --display west; yabai -m display --focus west;
      shift + alt - g : yabai -m window --display east; yabai -m display --focus east;


      # move window to prev and next space
      shift + alt - p : yabai -m window --space prev;
      shift + alt - n : yabai -m window --space next;

      # move window to space #
      shift + alt - 1 : yabai -m window --space 1;
      shift + alt - 2 : yabai -m window --space 2;
      shift + alt - 3 : yabai -m window --space 3;
      shift + alt - 4 : yabai -m window --space 4;
      shift + alt - 5 : yabai -m window --space 5;
      shift + alt - 6 : yabai -m window --space 6;
      shift + alt - 7 : yabai -m window --space 7;

      # -- Misc --
      # open new Alacritty window
      cmd - return : alacritty msg create-window
    '';
  };

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
      normal_window_opacity = 0.8;

      layout = "bsp";
      auto_balance = "off";
      split_ratio = 0.5;

      top_padding = 10;
      bottom_padding = 10 + 36;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;

      mouse_modifier = "alt";
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
