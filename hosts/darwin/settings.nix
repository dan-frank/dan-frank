{
  time.timeZone = "Europe/London";

  system.defaults = {
    LaunchServices.LSQuarantine = false;

    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff"; # Tink -> Default
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = false;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleMetricUnits = 1;
      AppleTemperatureUnit = "Celsius";
      AppleICUForce24HourTime = false;
      InitialKeyRepeat = 20;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };

    ActivityMonitor = {
      IconType = 5;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      autohide-time-modifier = 0.3;
      expose-animation-duration = 0.3;
      expose-group-by-app = true;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = true;
      mru-spaces = false;
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
      QuitMenuItem = true;
      ShowPathbar = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv"; # "icnv" = Icon view, "Nlsv" = List view, "clmv" = Column View, "Flwv" = Gallery View
      _FXShowPosixPathInTitle = false;
      FXEnableExtensionChangeWarning = false;
    };

    loginwindow = {
      GuestEnabled = false;
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

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
  };

  system.activationScripts = {
    springboard-transition-time = ''
      defaults write com.apple.dock springboard-show-duration -float 0.1
      defaults write com.apple.dock springboard-hide-duration -float 0.1
      defaults write com.apple.dock springboard-page-duration -float 0.1
    '';
  };
}
