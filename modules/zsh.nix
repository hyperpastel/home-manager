{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      l = "eza -la";
      update = "sudo nixos-rebuild switch --flake ~/.config/system";
      power = "cat /sys/class/power_supply/BAT0/capacity";

      hms = "home-manager switch";

      # Quick commands for editing important configurations
      vimconfig = "nix shell nixpkgs\\#lua-language-server --command nvim --cmd \"cd ~/.config/nvim\" ~/.config/nvim/init.lua";
      hmconfig = "nvim --cmd \"cd ~/.config/home-manager/\" ~/.config/home-manager/";
      sysconfig = "nvim --cmd \"cd ~/.config/system/\" ~/.config/system/";

      # Abbreviations for common directories
      p = "cd ~/projects";
      u = "cd ~/uni";
      d = "cd ~/documents";
      o = "cd ~/downloads";

      # Wireplumber 
      mute = "wpctl set-mute @DEFAULT_SINK@ 1";
      unmute = "wpctl set-mute @DEFAULT_SINK@ 0";

      # deez stands for deevelop zsh
      deez = "nix develop -c $SHELL";
    };

    initContent = ''
      autoload -Uz vcs_info
      precmd () { vcs_info }

      zstyle ':vcs_info:git:*' formats '(%b) '

      setopt PROMPT_SUBST
      PROMPT='[%1~] %F{green}''\${vcs_info_msg_0_}%F{white}$ '
    '';
  };
}
