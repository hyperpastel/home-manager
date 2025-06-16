{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}:

{
  imports = [
    ./modules/all.nix
    flake-inputs.nur.modules.homeManager.default
  ];

  programs.home-manager.enable = true;

  home = {
    username = "tori";
    homeDirectory = "/home/tori";
    stateVersion = "24.11";

    packages = with pkgs; [
      zathura
      wofi
      element-desktop
      nixd
    ];
  };

  programs.git = {
    enable = true;
    userName = "hyperpastel";
    userEmail = "vmutze04@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "rose-pine";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs; [
      vimPlugins.luasnip
    ];
  };

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        isDefault = true;

        settings = {
          "browser.urlbar.placeholderName" = "I am a Dragon.";
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
            "Nix Packages" = {
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
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            "Nix Options" = {
              definedAliases = [ "@no" ];
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
