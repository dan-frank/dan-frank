{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "1password"
      "alacritty"
      "bartender"
      "docker"
      "duckduckgo"
      "firefox"
      "google-chrome"
      "hazeover"
      "itsycal"
      "nightowl"
      "slack"
      "utm"
      "visual-studio-code"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "AdGuard for Safari" = 1440147259;
      "Bears Countdown" = 1536711520;
      "Bears Gratitude" = 6443609622;
      "Dark Reader for Safari" = 1438243180;
      "DuckDuckGo Privacy for Safari" = 1482920575;
      "JSON Peep for Safari" = 1458969831;
      Numbers = 409203825;
      Pages = 409201541;
      PiPifier = 1160374471;
      "scite extension" = 1551820111;
      "SponsorBlock for YouTube" = 1573461917;
      Vimari = 1480933944;
    };
  };
}

