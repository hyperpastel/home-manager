{ lib, ... }:

let
  current_wallpaper = "~/.config/home-manager/wallpaper.jpg";
in

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "monitor" = "eDP-1,1920x1200,auto,1";

      "$term" = "kitty";
      "$menu" = "wofi --show drun";

      "$mod" = "SUPER";

      windowrule = [
        "opacity 0.8 0.8 0.8, class:kitty"
      ];

      exec-once = [
        "hyprpaper"
      ];
      bind =
        [
          "$mod, M, exit"
          "$mod, F, fullscreen"
          "$mod, W, killactive"
          "$mod, Q, exec, $term"
          "$mod, Space, exec, $menu"

          "$mod SHIFT, S, exec, grim -g \"$(slurp -d)\" - | wl-copy" 

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

        ]
        ++ builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10
        );
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      preload = [ current_wallpaper ];
      wallpaper = [
        (lib.strings.concatStrings [
          "eDP-1"
          ","
          "${current_wallpaper}"
        ])
      ];
    };
  };
}
