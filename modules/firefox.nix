{
  pkgs,
  flake-inputs,
  ...
}:

let
  nixos-icon = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/logo/nix-snowflake-rainbow.svg";
in

{
  imports = [
    flake-inputs.nur.modules.homeManager.default
  ];

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        isDefault = true;

        settings = {
          "browser.urlbar.placeholderName" = "dragon power";
          "browser.urlbar.sponsoredTopSites" = false;
          "browser.startup.homepage" = "https://nixos.org";
        };

        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
        };

        search = {
          force = true;
          default = "ddg";
          engines = {
            bing.metaData.hidden = true;
            google.metaData.hidden = true;

            "Nix Packages" = {
              definedAliases = [ "@np" ];
              icon = nixos-icon;
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Nix Options" = {
              definedAliases = [ "@no" ];
              icon = nixos-icon;
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
            "Home Manager Options" = {
              definedAliases = [ "@ho" ];
              icon = nixos-icon;
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
                }
              ];
            };

            # Links for competitive Pokemon

            "Smogon SV" = {
              definedAliases = [ "@smsv" ];
              icon = "https://www.smogon.com/favicon.ico";
              urls = [
                {
                  template = "https://www.smogon.com/dex/sv/pokemon/{searchTerms}/";
                }
              ];
            };

            "Bulbapedia" = {
              definedAliases = [ "@bp" ];
              icon = "https://bulbapedia.bulbagarden.net/favicon.ico";
              urls = [
                {
                  template = "https://bulbapedia.bulbagarden.net/w/index.php?title=Special%3ASearch&search={searchTerms}";
                }
              ];
            };
          };
        };
      };
    };
  };
}
