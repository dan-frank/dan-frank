{
  system.defaults = {
    LaunchServices.LSQuarantine = false;

    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff"; # Tink -> Default
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      ApplePressAndHoldEnabled = true;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleTemperatureUnit = "Celsius";
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      _HIHideMenuBar = false;
    };

    ActivityMonitor = {
      IconType = 5;
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
      QuitMenuItem = true;
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

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
  };
}
