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
      "Bears Countdown" = 1536711520;
      "Bears Gratitude" = 6443609622;
      "1Password for Safari" = 1569813296;
      "DuckDuckGo Privacy for Safari" = 1482920575;
      "Dark Reader for Safari" = 1438243180;
      Vimari = 1480933944;
      "SponsorBlock for YouTube" = 1573461917;
      "AdGuard for Safari" = 1440147259;
      PiPifier = 1160374471;
      "JSON Peep for Safari" = 1458969831;
      "scite extension" = 1551820111;
      Pages = 409201541;
      Numbers = 409203825;
    };
  };
}

