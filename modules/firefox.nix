{
  pkgs,
  lib,
  ...
}:

let
  nixos-icon = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-rainbow.svg";
in

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;

    # Strongly inspired by
    # https://github.com/MultisampledNight/core/blob/main/system/platform/desktop.nix#L221

    policies = {
      Preferences = {
        "browser.preferences.defaultPerformanceSettings.enabled" = false;
        "browser.toolbar.bookmarks.visibility" = "newtab";
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.openpage" = false;
        "browser.urlbar.suggest.recentsearches" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.placeholderName" = "dragon power";
        "browser.startup.homepage" = "about:home";
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "places.history.enabled" = "false";
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
      };

      # Frick uppercase names
      DownloadDirectory = "\${home}/downloads";

      Cookies = {
        Behavior = "reject-foreign";
        BehaviorPrivateBrowsing = "reject";
        Locked = true;
      };

      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        Downloads = false;
        FormData = true;
        History = true;
        Sessions = true;
        SiteSettings = true;
        OfflineApps = true;
        Locked = false;
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };

      UserMessaging = {
        ExtensionsRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        Locked = true;
      };

      Permissions = {
        Camera.BlockNewRequests = true;
        Microphone.BlockNewRequests = true;
        Location.BlockNewRequests = true;
        Notifications.BlockNewRequests = true;
        Autoplay.Default = "block-audio-video";
      };

      NetworkPrediction = false;
      DNSOverHTTPS = {
        Enabled = true;
        Fallback = true;
      };

      OverridePostUpdatePage = "";
      NoDefaultBookmarks = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      PromptForDownloadLocation = false;
      HardwareAcceleration = true;

      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      DisableFormHistory = true;
      DisableBuiltinPDFViewer = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableTelemetry = true;
      DisableSetDesktopBackground = true;

      ShowHomeButton = false;
      # DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "never";

      ExtensionSettings =
        let
          extension = sid: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${sid}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        lib.listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "rose-pine-dark-theme" "{84496095-b7ad-496e-bce3-51cca2e43703}")
        ];

      Bookmarks =
        let
          mark = Title: URL: Favicon: { inherit Title URL Favicon; };
          groupByFolder = name: marks: (map (mark: mark // { Folder = name; }) marks);
        in

        # TODO Replace this once I have a proper favicon (this site isn't actually up LOL)
        [ (mark "Home" "https://hyperpas.tel" nixos-icon) ]

        ++ (groupByFolder "Coding" [
          (mark "Leetcode" "https://leetcode.com"
            "https://assets.leetcode.com/static_assets/public/icons/favicon-16x16.png"
          )
          (mark "Github" "https://github.com/hyperpastel"
            "https://github.githubassets.com/favicons/favicon.svg"
          )
          (mark "Codeforces" "https://codeforces.com/"
            "https://codeforces.org/s/12212/android-icon-192x192.png"
          )
        ])

        ++ (groupByFolder "Uni" [
          (mark "TUC" "https://tu-chemnitz.de" "https://www.tu-chemnitz.de/tucal4/img/tuc.png")
          (mark "Opal" "https://bildungsportal.sachsen.de/opal"
            "https://bildungsportal.sachsen.de/opal/raw/20250716/themes/opal_new/favicon.ico"
          )
        ])

        ++ (groupByFolder "Genshin" [
          (mark "Ascension Planner" "https://www.genshin-center.com/planner"
            "https://www.genshin-center.com/favicon.ico"
          )
          (mark "Interactive Map"
            "https://act.hoyolab.com/ys/app/interactive-map/index.html?lang=en-us#/map/2"
            "https://act.hoyolab.com/ys/app/interactive-map/mapicon.png"
          )
        ]);

      SearchBar = "unified";
      SearchEngines = {
        PreventInstalls = true;

        Default = "DuckDuckGo";
        Add = [

          {
            Name = "Nix Packages";
            Alias = "@np";
            IconURL = nixos-icon;
            URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
            Method = "GET";
          }

          {
            Name = "Nix Options";
            Alias = "@no";
            IconURL = nixos-icon;
            URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
            Method = "GET";
          }

          {
            Name = "Home Manager Options";
            Alias = "@ho";
            IconURL = nixos-icon;
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
            Method = "GET";
          }

          {
            Name = "Heroes 3 Wiki";
            Alias = "@h3";
            IconURL = "https://heroes.thelazy.net/favicon.ico";
            URLTemplate = "https://heroes.thelazy.net/index.php?search={searchTerms}&title=Special%3ASearch&go=Go";
            Method = "GET";
          }

        ];

        Remove = [
          "Google"
          "Bing"
        ];
      };
    };
  };
}
