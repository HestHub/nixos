{pkgs, ...}: let
  config = ''
    font-size = 14
    theme = "nordic"
    macos-titlebar-style = "hidden"
    font-family = "Fira Code"
    #background-blur = true
    #background-opacity = 0.95
    quick-terminal-position = center
    mouse-hide-while-typing = true

    # keybind = super+h=goto_split:left
    # keybind = super+j=goto_split:bottom
    # keybind = super+k=goto_split:top
    # keybind = super+l=goto_split:right
    #
    # keybind = cmd+d>h=new_split:left
    # keybind = cmd+d>j=new_split:down
    # keybind = cmd+d>k=new_split:up
    # keybind = cmd+d>l=new_split:right
    # keybind = cmd+d>d=close_surface
    #
    # keybind = cmd+shift+h=resize_split:left,10
    # keybind = cmd+shift+j=resize_split:down,10
    # keybind = cmd+shift+k=resize_split:up,10
    # keybind = cmd+shift+l=resize_split:right,10
    # keybind = cmd+e=equalize_splits
    #
    # keybind = cmd+f=toggle_split_zoom
    #
    keybind = global:cmd+grave_accent=toggle_quick_terminal


    keybind = cmd+j=unbind
    keybind = cmd+k=unbind
    keybind = cmd+l=unbind
    keybind = cmd+h=unbind

    keybind = cmd+f=unbind
    keybind = cmd+e=unbind

    keybind = cmd+d=unbind
    keybind = cmd+t=unbind
    keybind = cmd+w=unbind
    keybind = cmd+1=unbind
    keybind = cmd+2=unbind
    keybind = cmd+3=unbind
    keybind = cmd+4=unbind
    keybind = cmd+5=unbind
  '';

  theme = ''
    background = #242933
    foreground = #d8dee9
    cursor-color = #eceff4
    cursor-text = #282828
    selection-background = #eceff4
    selection-foreground = #4c566a
    palette = 0=#3b4252
    palette = 1=#bf616a
    palette = 2=#a3be8c
    palette = 3=#ebcb8b
    palette = 4=#81a1c1
    palette = 5=#b48ead
    palette = 6=#88c0d0
    palette = 7=#e5e9f0
    palette = 8=#4c566a
    palette = 9=#bf616a
    palette = 10=#a3be8c
    palette = 11=#ebcb8b
    palette = 12=#81a1c1
    palette = 13=#b48ead
    palette = 14=#8fbcbb
    palette = 15=#eceff4
  '';
in {
  # Linux: install and configure Ghostty
  programs.ghostty = pkgs.lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
  };

  # macOS: write TOML config to XDG_CONFIG_HOME
  xdg.configFile."ghostty/config".text = config;
  xdg.configFile."ghostty/themes/nordic".text = theme;
}
