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
      exec-once = [
        "hyprpaper"
      ];
      bind =
        [
          "$mod, M, exit"
          "$mod, F, fullscreen"
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
