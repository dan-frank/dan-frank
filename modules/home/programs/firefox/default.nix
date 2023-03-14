{ config, pkgs, lib, ... }:
let
  merge = lib.foldr (a: b: a // b) { };
  pkgsFirefox = if pkgs.stdenv.isLinux then pkgs.firefox else pkgs.firefox-bin;
in {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  home.shellAliases = {
    firefox = "Open ${pkgsFirefox}/Applications/Firefox.app";
  };

  programs.firefox = {
    enable = true;
    package = pkgsFirefox;
    profiles = {
      default = {
        name = "Default";
        settings = merge [
          (import ./config/annoyances.nix)
          (import ./config/browser-features.nix)
          (import ./config/privacy.nix)
          (import ./config/tracking.nix)
          (import ./config/security.nix)
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          (buildFirefoxXpiAddon {
            pname = "amazon-container";
            version = "2.0.0";
            addonId = "@contain-amzn";
            url = "https://addons.mozilla.org/firefox/downloads/file/3455930/contain_amazon-2.0.0.xpi";
            sha256 = "DmHAhYb1GFKCSWL5yi9Nj8nkKG8+KkQRGu3pZEI0scA=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "accumulate-daily-chinese-and-japanese";
            version = "0.1.10";
            addonId = "{61e10dd2-44fa-4cdc-a264-5cf23cee66ae}";
            url = "https://addons.mozilla.org/firefox/downloads/file/995671/accumulate-0.1.10.xpi";
            sha256 = "0MWuF5UfS2bYba8lH6m9/Jkqc9abQ8NcHJlMyVaB//E=";
            meta = {};
          })
          darkreader
          decentraleyes
          disconnect
          duckduckgo-privacy-essentials
          facebook-container
          (buildFirefoxXpiAddon {
            pname = "GarminGraphs";
            version = "1.3.1";
            addonId = "{93714d9d-3af9-4e4d-941d-1072bc3f5614}";
            url = "https://addons.mozilla.org/firefox/downloads/file/3943346/garmin_graphs-1.3.1.xpi";
            sha256 = "EuDENswWOPhro1gkMOtYDaSbbuL/Cx4uS/5XskFGcLM=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "grepper";
            version = "0.0.8.9";
            addonId = "{2cbcd5ed-d916-4805-a4d0-a8da4ca8f13f}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4069054/grepper-0.0.8.9.xpi";
            sha256 = "F9uLLxOPRCiC99tbpA5tKvWRxF4yLPMmJihwXHavGwQ=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "google-container";
            version = "1.5.4";
            addonId = "{a0b12c72-d317-464d-986e-1719831b5696}";
            url = "https://addons.mozilla.org/firefox/downloads/file/3736912/google_container-1.5.4.xpi";
            sha256 = "R6fA6FRoMyoNlJko2LdDdhks3kq6oUKAACs6yk7IFNA=";
            meta = {};
          })
          honey
          (buildFirefoxXpiAddon {
            pname = "jsonovich";
            version = "2.1.2";
            addonId = "{f9f111a8-22b4-4796-b6db-11cb14c2ac35}";
            url = "https://addons.mozilla.org/firefox/downloads/file/871010/jsonovich-2.1.2.xpi";
            sha256 = "zH/2qOzo3cwPakGTRUYjEZi3TGKmbqEwfHlD9uSRSkc=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "make-medium-readable-again";
            version = "1.5.2";
            addonId = "{28d1ed97-5ff6-432b-a26d-61896fe2cbed}";
            url = "https://addons.mozilla.org/firefox/downloads/file/1119197/make_medium_readable_again-1.5.2.xpi";
            sha256 = "bBdWI0b1WbpSZyYieoBChgSyW62N7ekMvdkvtoGVruc=";
            meta = {};
          })
          onepassword-password-manager
          (buildFirefoxXpiAddon {
            pname = "playback-speed";
            version = "1.4.4";
            addonId = "playbackSpeed@waldemar.b";
            url = "https://addons.mozilla.org/firefox/downloads/file/3864607/playback_speed-1.4.4.xpi";
            sha256 = "SfGV/gWtoTs5UF8sCqRGMeKH99GaIkIIXnclRD7MHP0=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "quidco-cashback-reminder";
            version = "3.0.14";
            addonId = "{6290266e-70b3-46f0-91c9-eb61c586a5b0}";
            url = "https://addons.mozilla.org/firefox/downloads/file/3600927/quidco_cashback-3.0.14.xpi";
            sha256 = "/DJVJfCcyoiwnp+0MW6dejK8ejFvaRT+765w9QMCgSM=";
            meta = {};
          })
          return-youtube-dislikes
          (buildFirefoxXpiAddon {
            pname = "Reverse Image Search";
            version = "3.4.4";
            addonId = "{0da2e603-21ba-4422-8049-b6d9e013ed84}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4074017/image_reverse_search-3.4.4.xpi";
            sha256 = "IsHnNfA9N9ZKYRu9bRSxyzKVoM4NkcXqyjuexKeCVKE=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "smart-https";
            version = "0.3.2";
            addonId = "{b3e677f4-1150-4387-8629-da738260a48e}";
            url = "https://addons.mozilla.org/firefox/downloads/file/3975277/smart_https_revived-0.3.2.xpi";
            sha256 = "niMdAfBHTqxGQ/Od+fXVfbi/01Anix7bRja/VgAK0SQ=";
            meta = {};
          })
          sourcegraph
          sponsorblock
          tab-session-manager
          (buildFirefoxXpiAddon {
            pname = "the-camelizer-price-tracker";
            version = "3.0.15";
            addonId = "izer@camelcamelcamel.com";
            url = "https://addons.mozilla.org/firefox/downloads/file/4075638/the_camelizer_price_history_ch-3.0.15.xpi";
            sha256 = "bHmXQrtSy6AYsQkCKyP/PZW/MkgQN+Qu1Q3THcnc8Ho=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "tiktok-container";
            version = "2.0.0";
            addonId = "@tiktok-container";
            url = "https://addons.mozilla.org/firefox/downloads/file/3637895/tiktok_container-2.0.0.xpi";
            sha256 = "p84kir/ZvoZ3AytR66oLfQgTJN55b6eH3aZ779ukPFE=";
            meta = {};
          })
          (buildFirefoxXpiAddon {
            pname = "twitter-container";
            version = "1.3.1";
            addonId = "@contain-twitter";
            url = "https://addons.mozilla.org/firefox/downloads/file/1043666/twitter_container-1.3.1.xpi";
            sha256 = "6RSCXLcI6G7SZPk+Oyt7JJGOEuPobDSydqwTuJNmOsw=";
            meta = {};
          })
          ublock-origin
          unpaywall
          vimium
          (buildFirefoxXpiAddon {
            pname = "zhongwen-the-popular-chinese-learning-tool";
            version = "5.14.1";
            addonId = "{dedb3663-6f13-4c6c-bf0f-5bd111cb2c79}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4060172/zhongwen-5.14.1.xpi";
            sha256 = "EIo1gEC/sJa2ADN/ZpnUbOf0jy+I9Rvn6L09MIxZxws=";
            meta = {};
          })
        ];
        userChrome = builtins.readFile ./chrome/onebar.css;
      };
      # This does not have as strict privacy settings as the default profile.
      # It uses the default firefox settings. Useful when something is not
      # working using the default profile
      insecure = {
        name = "insecure";
        id = 1;
      };
    };
  };
}
