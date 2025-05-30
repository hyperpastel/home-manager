{ config, pkgs, ... }:

{

  imports = [
    ./modules/all.nix
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

  programs.firefox.enable = true;
}
