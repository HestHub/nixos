{pkgs, ...}: let
  ghosttySettings = {
    "font-size" = 14;
    theme = "nord";
    title = "";
    "macos-titlebar-style" = "tabs";
    "mouse-hide-while-typing" = true;
  };

  ghosttyToml = (pkgs.formats.toml {}).generate "ghostty-config" ghosttySettings;
in {
  # Linux: install and configure Ghostty
  programs.ghostty = pkgs.lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
    settings = ghosttySettings;
  };

  # macOS: write TOML config to XDG_CONFIG_HOME
  xdg.configFile."ghostty/config".source = pkgs.lib.mkIf pkgs.stdenv.isDarwin ghosttyToml;
}
