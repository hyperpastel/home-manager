{
  pkgs,
  flake-inputs,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./zsh.nix
    ./firefox.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "v";
    homeDirectory = "/home/v";
    stateVersion = "24.11";

    packages =
      with pkgs;
      [
        wofi
        element-desktop
        nixd
        typos-lsp

        wineWow64Packages.stagingFull
        wl-clipboard

        # For screenshots
        grimblast
        grim
        slurp

        # needed for neovim treesitter
        nodejs
        gcc

        nix-output-monitor

        # Programs for typst
        typst
        tinymist

        # Various fonts
        noto-fonts
        nerd-fonts.iosevka-term-slab
        atkinson-hyperlegible-next
      ]
  };

  # For managing fonts with home-manager
  # https://github.com/nix-community/home-manager/issues/605

  fonts.fontconfig.enable = true;

  programs.zathura = {
    enable = true;
    options = {
      show-recent = 0;
      selection-clipboard = "clipboard";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "rose-pine-moon";
    font = {
      name = "IovsevkaTermSlab Nerd Font";
      size = 10;
    };
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      mgr = {
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

  services.mako = {
    enable = true;
    settings = {
      layer = "overlay";
      default-timeout = 5000;
    };
  };

}
