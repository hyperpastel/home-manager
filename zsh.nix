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
      update = "sudo nixos-rebuild switch --flake ~/system";
      power = "cat /sys/class/power_supply/BAT0/capacity";
      vimconfig = "nix shell nixpkgs\\#lua-language-server --command nvim --cmd \"cd ~/.config/nvim\" ~/.config/nvim/init.lua";
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
