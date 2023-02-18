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

  system.build.applications = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };

  system.activationScripts.applications.text = ''
    # Set up applications.
    echo "setting up /Applications/Nix Apps..." >&2

    ourLink () {
      local link
      link=$(readlink "$1")
      [ -L "$1" ] && [ "''${link#*-}" = 'system-applications/Applications' ]
    }

    # Clean up for links created at the old location in HOME
    if ourLink ~/Applications; then
      rm ~/Applications
    elif ourLink ~/Applications/'Nix Apps'; then
      rm ~/Applications/'Nix Apps'
    fi

    if [ ! -e '/Applications/Nix Apps' ] \
       || ourLink '/Applications/Nix Apps'; then
      ln -sfn ${cfg.build.applications}/Applications '/Applications/Nix Apps'
    else
      echo "warning: /Applications/Nix Apps is not owned by nix-darwin, skipping App linking..." >&2
    fi
  '';

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position                   = "top";
      display                    = "all";
      height                     = 36;
      title                      = "on";
      spaces                     = "on";
      clock                      = "on";
      power                      = "on";
      padding_left               = 20;
      padding_right              = 20;
      spacing_left               = 25;
      spacing_right              = 16;
      text_font                  = ''"Hack:Regular:12.0"'';
      icon_font                  = ''"Hack:Regular:12.0"'';
      background_color           = "0xff24292e";
      foreground_color           = "0xffa8a8a8";
      power_icon_color           = "0xff85e89d";
      battery_icon_color         = "0xfff97583";
      dnd_icon_color             = "0xffe0e2e4";
      clock_icon_color           = "0xffe0e2e4";
      power_icon_strip           = " ";
      space_icon                 = "•";
      space_icon_strip           = "I II III IV V VI VII VIII IX X";
      spaces_for_all_displays    = "on";
      display_separator          = "on";
      display_separator_icon     = "";
      space_icon_color           = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary  = "0xfffff9b0";
      clock_icon                 = "";
      dnd_icon                   = "";
      clock_format               = ''"%d/%m/%y %R"'';
      right_shell                = "off";
      right_shell_icon           = "";
      right_shell_command        = "whoami";
    };
  };
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  services.spacebar.config.debug_output = "on";
  launchd.user.agents.spacebar.serviceConfig.StandardErrorPath = "/tmp/spacebar.err.log";
  launchd.user.agents.spacebar.serviceConfig.StandardOutPath = "/tmp/spacebar.out.log";
}
