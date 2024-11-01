{
  flakeConfig,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    # master.no_gaps_when_only = 1;

    # enable blur for popups
    layerrule = [
      "blur, bar"
      "blurpopups, bar"
      "ignorezero, bar"
    ];

    # blur for unfocused windows
    windowrulev2 = [
      "opacity 1.0 override 0.9 override 1.0 override,title:^(.*)$"
    ];

    general =
      let
        gaps = 7;
        removeHash = colour: lib.replaceStrings [ "#" ] [ "" ] colour;
      in
      {
        gaps_in = gaps;
        gaps_out = gaps * 2;
        border_size = 1;
        allow_tearing = true;
        resize_on_border = false;

        "col.active_border" = "rgb(${removeHash flakeConfig.colorscheme.bright.black})";
        "col.inactive_border" = "rgb(${removeHash flakeConfig.colorscheme.normal.black})";
      };

    decoration = {
      rounding = 7;
      drop_shadow = false;

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        new_optimizations = true;
        noise = 2.0e-2;
        passes = 2;
        size = 5;
        xray = false;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "md3_decel, 0.05, 0.7, 0.1, 1"
      ];

      animation = [
        "border, 1, 2, default"
        "fade, 1, 2, md3_decel"
        "windows, 1, 4, md3_decel, popin 60%"
        "workspaces, 1, 4, md3_decel, slide"
      ];
    };

    input = {
      kb_layout = "us";

      # i actually like how it behaves this way lol
      # accel_profile = "flat";
      follow_mouse = 1;
      sensitivity = 0.1;

      # increasing repeat keys rate
      repeat_rate = 45;
      repeat_delay = 250;

      # laptop only
      touchpad = {
        disable_while_typing = false;
        natural_scroll = true;
        scroll_factor = 0.5;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    misc = {
      animate_mouse_windowdragging = true;
      disable_autoreload = false;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      force_default_wallpaper = 1;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
      vfr = true;
      vrr = 1;
    };

    # my own monitor fix...
    monitor = [ "HDMI-A-1,preferred,auto,1" ];

    xwayland = {
      force_zero_scaling = true;
    };
  };
}
