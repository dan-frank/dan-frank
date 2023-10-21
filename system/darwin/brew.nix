{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };
    global = {
      autoUpdate = true;
      brewfile = true;
      lockfiles = true;
    };
    casks = [
      # == Brew only ==
      "1password"
      "duckduckgo"
      "macfuse"

      # == To allow app access via spotlight ==
      "alacritty"
      "docker"
      "visual-studio-code"
    ];
    masApps = { # App Store applications
      "1Password for Safari" = 1569813296;
      "AdGuard for Safari" = 1440147259;
      "Bears Countdown" = 1536711520;
      "Dark Reader for Safari" = 1438243180;
      "DuckDuckGo Privacy for Safari" = 1482920575;
      "JSON Peep for Safari" = 1458969831;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      "Reeder 5" = 1529448980;
      "SponsorBlock for YouTube" = 1573461917;
      Vimari = 1480933944;
    };
  };
}

