{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };
    global = {
      autoUpdate = true;
      brewfile = true;
      lockfiles = true;
    };
    casks = [
      # == Brew only ==
      "1password"
      "tableplus"

      # == To allow app access via spotlight ==
      "docker"
      "kitty"
      "visual-studio-code"
      "zen-browser"
    ];
    # App Store applications
    masApps = {
      "Bears Countdown" = 1536711520;
      "Endel: Focus, Sleep, Relax" = 1346247457;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      "Reeder 5" = 1529448980;

      # == Safari extensions ==
      "1Password for Safari" = 1569813296;
      "AdGuard for Safari" = 1440147259;
      "Dark Reader for Safari" = 1438243180;
      "DuckDuckGo Privacy for Safari" = 1482920575;
      "JSON Peep for Safari" = 1458969831;
      "SponsorBlock for YouTube" = 1573461917;
      Vimari = 1480933944;
    };
  };
}
