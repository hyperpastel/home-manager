let
  PROMPT = "'\${PROJECT_PREFIX:+\$(__get_shell_prefix) }[%1~] %F{green}\${vcs_info_msg_0_}%F{white}$ '";
in
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

      # nmcli
      wifi = "nmcli device wifi";

      # deez stands for deevelop zsh
      deez = "nix develop -c $SHELL";

      # quickly open relevant files
      flake = "$EDITOR flake.nix";
      makelists = "$EDITOR CMakeLists.txt";
      makefile = "$EDITOR Makefile";
    };

    initContent = ''
      autoload -Uz vcs_info
      precmd () { vcs_info }

      zstyle ':vcs_info:git:*' formats '(%b) '

      __get_shell_prefix() {
        echo "[%F{red}$PROJECT_PREFIX%f]"
      }

      setopt PROMPT_SUBST
      PROMPT=${PROMPT}
    '';
  };
}
