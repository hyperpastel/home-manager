{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor" = "eDP-1,1920x1200,auto,1";

      "$term" = "kitty";
      "$menu" = "wofi --show drun";

      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, fullscreen"
          "$mod, W, killactive"
          "$mod, Q, exec, $term"
          "$mod, Space, exec, $menu"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        ));
    };
  };
}
