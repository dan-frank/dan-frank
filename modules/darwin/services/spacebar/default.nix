{ config, pkgs, ... }:
{
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

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
      text_font                  = ''"TerminessTTF Nerd Font:Medium:17.0"'';
      icon_font                  = ''"TerminessTTF Nerd Font:Medium:17.0"'';
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
  services.spacebar.config.debug_output = "on";

  launchd.user.agents.spacebar.serviceConfig.StandardErrorPath = "/tmp/spacebar.err.log";
  launchd.user.agents.spacebar.serviceConfig.StandardOutPath = "/tmp/spacebar.out.log";
}
