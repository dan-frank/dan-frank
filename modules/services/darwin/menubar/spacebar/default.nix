{ pkgs, lib, config, ... }:
with config.colorscheme.palette;
let
  cfg = config.services.darwin.spacebar;
in {
  options.services.darwin.spacebar = {
    enable = lib.mkEnableOption "Enables Spacebar and configuration";

    height = lib.mkOption {
      default = 36;
      type = lib.types.int;
      description = "Height of the Spacebar in pixels";
    };

    position = lib.mkOption {
      default = "top";
      type = lib.types.enum ["top" "bottom"];
      description = "Position of the bar on the screen";
    };
  };

  config = lib.mkIf cfg.enable {
    system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    services.yabai.config = lib.mkIf config.services.darwin.yabai.enable {
      external_bar = if cfg.position == "top" then
        "all:${toString cfg.height}:0"
      else
        "all:0:${toString cfg.height}";
    };

    services.darwin.spacebar = {
      height = 36;
      position = "bottom";
    };

    services.spacebar = {
      enable = true;
      package = pkgs.spacebar;
      config = {
        display                    = "all";
        position                   = cfg.position;
        height                     = cfg.height;
        padding_left               = 20;
        padding_right              = 20;
        spacing_left               = 25;
        spacing_right              = 16;
        background_color           = "0xff${base00}";
        foreground_color           = "0xff${base05}";
        text_font                  = ''"${config.fontProfiles.regular.family}:Bold:16.0"'';
        icon_font                  = ''"${config.fontProfiles.monospace.family}:Bold:16.0"'';
        title                      = "on";
        display_separator          = "on";
        display_separator_icon     = "  ";
        spaces                     = "on";
        spaces_for_all_displays    = "on";
        space_icon                 = "•";
        space_icon_strip           = "I II III IV V VI VII VIII IX";
        space_icon_color           = "0xff${base0C}";
        space_icon_color_secondary = "0xff${base0D}";
        space_icon_color_tertiary  = "0xff${base0E}";
        right_shell                = "off";
        right_shell_icon           = "";
        right_shell_command        = "whoami";
        battery_icon_color         = "0xff${base08}";
        power                      = "on";
        power_icon_color           = "0xff${base0B}";
        power_icon_strip           = " ";
        dnd                        = "on";
        dnd_icon                   = "";
        dnd_icon_color             = "0xff${base0D}";
        clock                      = "on";
        clock_icon                 = "";
        clock_format               = ''"%d/%m/%y %R"'';
        clock_icon_color           = "0xff${base06}";

        debug_output = "on";
      };
    };

    launchd.user.agents.spacebar.serviceConfig = {
      StandardErrorPath = "/tmp/spacebar.err.log";
      StandardOutPath = "/tmp/spacebar.out.log";
    };
  };
}
