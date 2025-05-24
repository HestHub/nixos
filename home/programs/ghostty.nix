{pkgs, ...}: let
  ghosttyText = ''
    font-size = 14
    theme = "nord"
    macos-titlebar-style = "tabs"
    font-family = "Fira Code"
    background-blur = true
    background-opacity = 0.95

    quick-terminal-position = center

    keybind = super+h=goto_split:left
    keybind = super+j=goto_split:bottom
    keybind = super+k=goto_split:top
    keybind = super+l=goto_split:right

    # todo
    # keybind = ???=new_split:left
    # keybind = ???=new_split:down
    # keybind = ???=new_split:top
    # keybind = ???=new_split:right

    keybind = cmd+shift+h=resize_split:left,10
    keybind = cmd+shift+j=resize_split:down,10
    keybind = cmd+shift+k=resize_split:up,10
    keybind = cmd+shift+l=resize_split:right,10

    keybind = cmd+e=equalize_splits
    keybind = cmd+f=toggle_split_zoom

    keybind = global:cmd+grave_accent=toggle_quick_terminal

    mouse-hide-while-typing = true
  '';
in {
  # Linux: install and configure Ghostty
  programs.ghostty = pkgs.lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
    settings = ghosttyText;
  };

  # macOS: write TOML config to XDG_CONFIG_HOME
  xdg.configFile."ghostty/config".text = pkgs.lib.mkIf pkgs.stdenv.isDarwin ghosttyText;
}
