{ config, pkgs, lib, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  programs.firefox = {
    enable = true;
    package = if pkgs.stdenv.isLinux then pkgs.firefox else pkgs.firefox-bin;
    profiles =
    let
      defaultSettings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "https://lobste.rs";
        "browser.search.region" = "GB";
        "browser.search.countryCode" = "GB";
        "browser.search.isUS" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.newtabpage.enabled" = false;
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.uidensity" = 1;
        "browser.urlbar.update1" = true;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        # "identity.fxaccounts.account.device.name" = config.networking.hostName;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
        "services.sync.declinedEngines" = "addons,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.prefs" = true;
        "signon.rememberSignons" = false;
      };
    in {
      home = {
        id = 0;
        settings = defaultSettings // {
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          sourcegraph
          sponsorblock
          ublock-origin
          vimium
        ];
        userChrome = ''
          /*
           *  Hide window controls
           */
          .titlebar-buttonbox-container{
              display: none !important;
          }

          .titlebar-placeholder,
          #TabsToolbar .titlebar-spacer{ display: none; }
          #navigator-toolbox::after{ display: none !important; }


          /*
           *  Hide all the clutter in the navbar
           */
          #main-window :-moz-any(#back-button,
                     #forward-button,
                     #stop-reload-button,
                     #home-button,
                     #library-button,
                     #sidebar-button,
                     #star-button,
                     #pocket-button,
                     #permissions-granted-icon,
                     #fxa-toolbar-menu-button,
                     #_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action, /* Vimium */
                     #ublock0_raymondhill_net-browser-action) { display: none !important; }

          /*
           *  Hide tabs if only one tab
           */
          #titlebar .tabbrowser-tab[first-visible-tab="true"][last-visible-tab="true"]{
              display: none !important;
          }

          /*
           *  Minimal theme
           */
          #navigator-toolbox {
              font-family: 'Menlo' !important;
              border-bottom: 1px;
              border-bottom-color: #93a1a1 !important;
          }

          #navigator-toolbox toolbarspring {
              display: none;
          }

          /* Move tab line to the bottom */
          #navigator-toolbox .tab-line {
              -moz-box-ordinal-group: 2;
          }

          .tab-line[selected=true] {
              background-color: #2aa198 !important;
          }

          #navigator-toolbox #urlbar-container {
              padding: 0 !important;
              margin: 0 !important;
          }

          #navigator-toolbox #urlbar {
              border: none !important;
              border-radius: 0 !important;
              box-shadow: none !important;
          }

          #navigator-toolbox #PanelUI-button {
              padding: 0 !important;
              margin: 0 !important;
              border: none !important;
          }

          #navigator-toolbox #nav-bar {
              background: #fdf6e3 !important;
              box-shadow: none !important;
          }

          #navigator-toolbox #pageActionButton {
              display: none;
          }

          #navigator-toolbox #pageActionSeparator {
              display: none;
          }

          #fullscr-toggler {
              height: 0 !important;
          }

          #navigator-toolbox .urlbar-history-dropmarker {
              display: none;
          }

          #navigator-toolbox #tracking-protection-icon-container {
              padding-right: 0 !important;
              border: none !important;
              display: none !important;
          }

          #navigator-toolbox .tab-close-button, #navigator-toolbox #tabs-newtab-button {
              display: none;
          }

          #navigator-toolbox .toolbar-items {
              background: #fdf6e3  !important;
          }

          #navigator-toolbox #urlbar {
              background: #fdf6e3 !important;;
              color: #586e75 !important;
              padding: 0 !important;
              padding-left: 1ch !important;
              font-size: 13px;
              height: 20px;
          }

          #navigator-toolbox #urlbar-background {
              background: #fdf6e3 !important;;
              border: none !important;
              margin: 0 !important;
          }

          #navigator-toolbox #nav-bar-customization-target {
              background: #fdf6e3 !important;;
          }

          #navigator-toolbox .toolbarbutton-1 {
              width: 22px;
          }

          #navigator-toolbox #downloads-button {
              color: #fdf6e3 ;
              background: #fdf6e3 !important;
          }

          #navigator-toolbox #PanelUI-button {
              opacity: 1 !important;
              background: #fdf6e3 !important;
          }

          #navigator-toolbox #PanelUI-menu-button {
              background: #fdf6e3 !important;
              color: #586e75 !important;
          }

          #navigator-toolbox .tabbrowser-tab {
              font-size: 12px
          }

          #navigator-toolbox .tab-background {
              background: #fdf6e3  !important;
              box-shadow: none!important;
              border: none !important;
          }

          #navigator-toolbox .tabbrowser-tab .tab-label {
              color: #586e75 !important;
          }

          #navigator-toolbox .tab-background[selected="true"] {
              background: #fdf6e3  !important;
          }

          #navigator-toolbox .tabbrowser-tab[selected="true"] .tab-label {
              color: #586e75 !important;
          }

          #navigator-toolbox .tabbrowser-tab::after {
              display: none !important;
          }

          #navigator-toolbox #urlbar-zoom-button {
              border: none !important;
          }

          #appMenu-fxa-container, #appMenu-fxa-container + toolbarseparator {
              display: none !important;
          }

          #sync-setup {
              display: none !important;
          }

          /*
           *  Hamburger menu to the left
           */

          #PanelUI-button {
              -moz-box-ordinal-group: 0;
              border-left: none !important;
              border-right: none !important;
              position: absolute;
          }

          #toolbar-context-menu .viewCustomizeToolbar {
              display: none !important;
          }

          :root[uidensity=compact] #PanelUI-button {
              margin-top: -28px;
          }

          #PanelUI-button {
              margin-top: -30px;
          }

          :root[uidensity=touch] #PanelUI-button {
              margin-top: -36px;
          }

          /*
           *  Tabs to the right of the urlbar
           */

          /* Modify these to change relative widths or default height */
          #navigator-toolbox{
              --uc-navigationbar-width: 40vw;
              --uc-toolbar-height: 40px;
          }
          /* Override for other densities */
          :root[uidensity="compact"] #navigator-toolbox{ --uc-toolbar-height: 32px; }
          :root[uidensity="touch"] #navigator-toolbox{ --uc-toolbar-height: 40px; }

          :root[uidensity=compact] #urlbar-container.megabar{
              --urlbar-container-height: var(--uc-toolbar-height) !important;
              padding-block: 0 !important;
          }
          :root[uidensity=compact] #urlbar.megabar{
              --urlbar-toolbar-height: var(--uc-toolbar-height) !important;
          }

          /* prevent urlbar overflow on narrow windows */
          /* Dependent on how many items are in navigation toolbar ADJUST AS NEEDED */
          @media screen and (max-width: 1300px){
              #urlbar-container{ min-width:unset !important }
          }

          #TabsToolbar{ margin-left: var(--uc-navigationbar-width); }
          #tabbrowser-tabs{ --tab-min-height: var(--uc-toolbar-height) !important; }

          /* This isn't useful when tabs start in the middle of the window */
          .titlebar-placeholder[type="pre-tabs"],
          .titlebar-spacer[type="pre-tabs"]{ display: none }

          #navigator-toolbox > #nav-bar{
              margin-right:calc(100vw - var(--uc-navigationbar-width));
              margin-top: calc(0px - var(--uc-toolbar-height));
          }

          /* Zero window drag space  */
          :root[tabsintitlebar="true"] #nav-bar{ padding-left: 0px !important; padding-right: 0px !important; }

          /* 1px margin on touch density causes tabs to be too high */
          .tab-close-button{ margin-top: 0 !important }

          /* Hide dropdown placeholder */
          #urlbar-container:not(:hover) .urlbar-history-dropmarker{ margin-inline-start: -28px; }

          /* Fix customization view */
          #customization-panelWrapper > .panel-arrowbox > .panel-arrow{ margin-inline-end: initial !important; }
        '';
      };

      work = {
        id = 1;
        settings = defaultSettings // {
          "browser.startup.homepage" = "about:blank";
        };
      };
    };
  };
}
