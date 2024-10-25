{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    bind =
      let
        utils = import ./utils.nix { inherit pkgs lib; };
        num-workspaces = 7;

        workspaces =
          let
            generator =
              x:
              let
                ws =
                  let
                    c = (x + 1) / num-workspaces;
                  in
                  builtins.toString (x + 1 - (c * num-workspaces));
              in
              [
                "SUPER, ${ws}, workspace, ${toString (x + 1)}"
                "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ];
          in
          builtins.concatLists (builtins.genList generator num-workspaces);

        reloadAgs = utils.silentScript "reload-ags" ''
          pgrep -x .ags-wrapped > /dev/null 2>&1 && kill -9 $(pgrep -x .ags-wrapped)
          ags & disown
        '';
      in
      workspaces
      ++ [
        "SUPERSHIFT, Delete, exit"
        "SUPER, Q, killactive"
        "SUPER, S, togglesplit"
        "SUPER, F, fullscreen"
        "SUPER, P, pseudo"
        "SUPERSHIFT, P, pin"
        "SUPER, Space, togglefloating"

        # utils scripts
        "SUPER SHIFT, R, exec, ${reloadAgs}"

        # move focus
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        # Move windows
        "SUPERSHIFT, left, movewindow, l"
        "SUPERSHIFT, right, movewindow, r"
        "SUPERSHIFT, up, movewindow, u"
        "SUPERSHIFT, down, movewindow, d"

        # Utilities
        "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "SUPERSHIFT, Return, exec, ${pkgs.wofi}/bin/wofi --show drun"
      ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
}
