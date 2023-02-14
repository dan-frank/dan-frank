{ config, pkgs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # services.nix-daemon.package = pkgs.nixFlakes;

  programs.zsh.enable = true;

  users = {
    users.dan = {
      name = "dan";
      home = "/Users/dan";
      shell = pkgs.zsh;
    };
  };

  # nixpkgs = {
  #   config = {
  #     allowUnfree = true;
  #     allowBroken = false;
  #     allowInsecure = false;
  #     allowUnsupportedSystem = false;
  #   };
  # };

  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   users.dan = import ./home.nix;
  # };

  environment.systemPackages = with pkgs; [
    # _1password-gui
    alacritty
    rectangle
    slack
    utm
    vscode
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Hack"
        "JetBrainsMono"
      ];
    })
  ];
  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [
  #     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  #   ];
  # };

  system = {
    stateVersion = 4;

    # yabai = {
    #   enable = false;
    #   package = pkgs.yabai;
    #   enableScriptingAddition = true;
    #   config = {
    #     focus_follows_mouse          = "off";
    #     mouse_follows_focus          = "off";
    #     external_bar                 = "all:24:0";
    #     window_placement             = "second_child";
    #     window_opacity               = "on";
    #     window_opacity_duration      = "0.0";
    #     window_border                = "on";
    #     window_border_placement      = "inset";
    #     window_border_width          = 2;
    #     window_border_radius         = 3;
    #     active_window_border_topmost = "off";
    #     window_topmost               = "on";
    #     window_shadow                = "float";
    #     active_window_border_color   = "0xff5c7e81";
    #     normal_window_border_color   = "0xff505050";
    #     insert_window_border_color   = "0xffd75f5f";
    #     active_window_opacity        = "1.0";
    #     normal_window_opacity        = "0.8";
    #     split_ratio                  = "0.50";
    #     auto_balance                 = "on";
    #     mouse_modifier               = "fn";
    #     mouse_action1                = "move";
    #     mouse_action2                = "resize";
    #     layout                       = "bsp";
    #     top_padding                  = 10;
    #     bottom_padding               = 10;
    #     left_padding                 = 10;
    #     right_padding                = 10;
    #     window_gap                   = 10;
    #   };
    # };

    # spacebar = {
    #   enable = true;
    #   package = pkgs.spacebar;
    #   config = {
    #     position                   = "top";
    #     display                    = "main";
    #     height                     = 24;
    #     title                      = "on";
    #     spaces                     = "on";
    #     clock                      = "on";
    #     power                      = "on";
    #     padding_left               = 20;
    #     padding_right              = 20;
    #     spacing_left               = 25;
    #     spacing_right              = 15;
    #     text_font                  = ''"Hack Nerd Font:Regular:12.0"'';
    #     icon_font                  = ''"Hack Nerd Font:Regular:12.0"'';
    #     background_color           = "0xff202020";
    #     foreground_color           = "0xffa8a8a8";
    #     power_icon_color           = "0xffcd950c";
    #     battery_icon_color         = "0xffd75f5f";
    #     dnd_icon_color             = "0xffa8a8a8";
    #     clock_icon_color           = "0xffa8a8a8";
    #     power_icon_strip           = " ";
    #     space_icon                 = "•";
    #     space_icon_strip           = "1 2 3 4 5 6 7 8 9 10";
    #     spaces_for_all_displays    = "on";
    #     display_separator          = "on";
    #     display_separator_icon     = "";
    #     space_icon_color           = "0xff458588";
    #     space_icon_color_secondary = "0xff78c4d4";
    #     space_icon_color_tertiary  = "0xfffff9b0";
    #     clock_icon                 = "";
    #     dnd_icon                   = "";
    #     clock_format               = ''"%d/%m/%y %R"'';
    #     right_shell                = "on";
    #     right_shell_icon           = "";
    #     right_shell_command        = "whoami";
    #   };
    # };

    defaults = {
      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff"; # Tink -> Default
      };

      ActivityMonitor = {
        IconType = 5;
      };

      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = false;
        AppleEnableSwipeNavigateWithScrolls = true;
        AppleShowScrollBars = "WhenScrolling";
        AppleTemperatureUnit = "Celsius";
      };

      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = false;
      };

      dock = {
        appswitcher-all-displays = true;
        autohide = true;
        expose-group-by-app = true;
        launchanim = true;
        mineffect = "genie";
        minimize-to-application = false;
        mru-spaces = true;
        orientation = "bottom";
        show-process-indicators = false;
        show-recents = false;
        showhidden = true;
        tilesize = 48;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = true;
        FXEnableExtensionChangeWarning = true;
        FXPreferredViewStyle = "icnv";
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
      };

      screencapture = {
        disable-shadow = false;
        location = "~/Downloads";
        type = "jpg";
      };

      trackpad = {
        Clicking = false;
        TrackpadRightClick = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = false;
    };
  };
}

