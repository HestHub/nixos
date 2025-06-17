{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    yabai
    skhd
  ];
  environment.variables.EDITOR = "nvim";

  services.tailscale.enable = true;

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # toggle window split type
      alt - e : yabai -m window --toggle split

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # mirror tree y-axis
      alt - y : yabai -m space --mirror y-axis

      # mirror tree x-axis
      alt - x : yabai -m space --mirror x-axis

      # balance size of windows
      shift + alt - 0 : yabai -m space --balance

      # get name of curretn window
      shift + alt - v : yabai -m query --windows --window | jq | pbcopy
      # toggle window native fullscreen
      shift + alt - f : yabai -m window --toggle native-fullscreen

      # toggle window float
      shift + alt - t : yabai -m window --toggle float && yabai -m window --grid 4:4:1:1:2:2

      # fast focus desktop
      alt+shift - 1 : yabai -m space --focus    i
      alt+shift - 2 : yabai -m space --focus   ii
      alt+shift - 3 : yabai -m space --focus  iii
      alt+shift - 4 : yabai -m space --focus   iv
      alt+shift - 5 : yabai -m space --focus    v

      ctrl + alt - 1 : yabai -m window --space    i; yabai -m space --focus    i
      ctrl + alt - 2 : yabai -m window --space   ii; yabai -m space --focus   ii
      ctrl + alt - 3 : yabai -m window --space  iii; yabai -m space --focus  iii
      ctrl + alt - 4 : yabai -m window --space   iv; yabai -m space --focus   iv
      ctrl + alt - 5 : yabai -m window --space    v; yabai -m space --focus    v

      # toggle stack icons
      shift + alt - b :  hs -c 'stackline.config:toggle("appearance.showIcons")'

      #reset layout ( undo stacking )
      ctrl + alt - b: yabai -m space --layout bsp

      #stack windows
      cmd + ctrl - left  : yabai -m window west --stack $(yabai -m query --windows --window | jq -r '.id')
      cmd + ctrl - down  : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id')
      cmd + ctrl - up    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id')
      cmd + ctrl - right : yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id')

      # focus up/down stack
      ctrl - up : yabai -m window --focus stack.prev
      ctrl - down : yabai -m window --focus stack.next

      # shift windows and focus space
      ctrl + shift - left : yabai -m window --space prev; yabai -m space --focus prev
      ctrl + shift - right : yabai -m window --space next; yabai -m space --focus next

    '';
  };

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "autofocus";
      window_placement = "second_child";
      window_topmost = "off";
      window_shadow = "on";
      window_opacity = "off";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.90";
      window_border = "off";
      window_border_width = "6";
      active_window_border_color = "0xff775759";
      normal_window_border_color = "0xff555555";
      insert_feedback_color = "0xffd75f5f";
      split_ratio = "0.50";
      auto_balance = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
      mouse_follows_focus = "on";
      layout = "bsp";
      top_padding = "05";
      bottom_padding = "10";
      left_padding = "10";
      right_padding = "10";
      window_gap = "06";
    };
    extraConfig = ''
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create
      # yabai -m space --create

      yabai -m space 1 --label i --layout stack
      yabai -m space 2 --label ii
      yabai -m space 3 --label iii
      yabai -m space 4 --label iv

      yabai -m rule --add app="^System Settings$" manage=off layer=above
      yabai -m rule --add app="^Calculator$" manage=off layer=above
      yabai -m rule --add app="^Simulator$" manage=off layer=above

      yabai -m rule --add app="Microsoft Teams$" space=1
      yabai -m rule --add app="Slack$" space=1
      yabai -m rule --add app="Mail$" space=1

      yabai -m rule --add app="Safari$" space=2
      yabai -m rule --add app="Ghostty$" space=3

      ## focus previous window when window destroyed
      yabai -m signal --add event=window_destroyed action="yabai -m window --focus mouse"
    '';
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    masApps = {
      Keynote = 409183694;
      MonitorControl-Lite = 1595464182;
      Amphetamine = 937984704;
    };

    brews = [
      "mas"
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
    ];

    casks = [
      "alt-tab"
      "tailscale" # easier to manage
      "mqttx" # not available on arm
      "microsoft-teams" # old version only on nix
      "microsoft-auto-update"
      "raycast" # todo
      "sanesidebuttons"
      "steam"
      "keymapp"
      "krita"
      "ghostty"
    ];
  };
}
