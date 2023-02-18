{
  system.defaults = {
    LaunchServices.LSQuarantine = false;

    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Funk.aiff"; # Tink -> Default
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = true;
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
      _HIHideMenuBar = true;
    };

    ActivityMonitor = {
      IconType = 5;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      autohide-time-modifier = 0.5;
      expose-animation-duration = 0.5;
      expose-group-by-app = true;
      launchanim = true;
      mineffect = "genie";
      minimize-to-application = false;
      mouse-over-hilite-stack = true;
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
      ShowPathbar = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "icnv";
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

    spaces.spans-displays = true;

    trackpad = {
      Clicking = false;
      TrackpadRightClick = true;
    };

    universalaccess = {
      reduceTransparency = false;
      closeViewScrollWheelToggle = true;
      closeViewZoomFollowsFocus = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = false;
  };

  time.timeZone = "Europe/London";
}
