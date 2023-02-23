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
      ## Navigation
      # Window Navigation (through display borders)
      alt - h : yabai -m window --focus west  || yabai -m display --focus west
      alt - j : yabai -m window --focus south || yabai -m display --focus south
      alt - k : yabai -m window --focus north || yabai -m display --focus north
      alt - l : yabai -m window --focus east  || yabai -m display --focus east

      # Make window zoom to fullscreen
      shift + lalt - f : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus

      ## Window Movement
      # Moving windows in spaces
      shift + alt - h : yabai -m window --warp west || $(yabai -m window --display west && sketchybar --trigger windows_on_spaces && yabai -m display --focus west && yabai -m window --warp last) || yabai -m window --move rel:-10:0
      shift + alt - j : yabai -m window --warp south || $(yabai -m window --display south && sketchybar --trigger windows_on_spaces && yabai -m display --focus south) || yabai -m window --move rel:0:10
      shift + alt - k : yabai -m window --warp north || $(yabai -m window --display north && sketchybar --trigger windows_on_spaces && yabai -m display --focus north) || yabai -m window --move rel:0:-10
      shift + alt - l : yabai -m window --warp east || $(yabai -m window --display east && sketchybar --trigger windows_on_spaces && yabai -m display --focus east && yabai -m window --warp first) || yabai -m window --move rel:10:0

      # Toggle split orientation of the selected windows node
      shift + alt - s : yabai -m window --toggle split

      # Moving windows between spaces
      shift + alt - p : yabai -m window --space prev; yabai -m space --focus prev; sketchybar --trigger windows_on_spaces
      shift + alt - n : yabai -m window --space next; yabai -m space --focus next; sketchybar --trigger windows_on_spaces

      # Mirror Space on X and Y Axis
      shift + alt - x : yabai -m space --mirror x-axis
      shift + alt - y : yabai -m space --mirror y-axis

      ## Stacks
      # Add the active window to the window or stack to the {direction}
      shift + ctrl - h    : yabai -m window  west --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
      shift + ctrl - j    : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
      shift + ctrl - k    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus
      shift + ctrl - l    : yabai -m window  east --stack $(yabai -m query --windows --window | jq -r '.id'); sketchybar --trigger window_focus

      # Stack Navigation
      shift + ctrl - n : yabai -m window --focus stack.next
      shift + ctrl - p : yabai -m window --focus stack.prev

      ## Resize
      # Resize windows
      ctrl + alt - h    : yabai -m window --resize right:-100:0 || yabai -m window --resize left:-100:0
      ctrl + alt - j    : yabai -m window --resize bottom:0:100 || yabai -m window --resize top:0:100
      ctrl + alt - k    : yabai -m window --resize bottom:0:-100 || yabai -m window --resize top:0:-100
      ctrl + alt - l : yabai -m window --resize right:100:0 || yabai -m window --resize left:100:0

      # Equalize size of windows
      ctrl + alt - e : yabai -m space --balance

      # Enable / Disable gaps in current workspace
      ctrl + alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

      ## Misc
      # Open new Alacritty window
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
