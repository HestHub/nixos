{pkgs, ...}: let
  ghosttyConfig = {
    "font-size" = 14;
    theme = "nord";
    title = "";
    "macos-titlebar-style" = "tabs";
    "mouse-hide-while-typing" = true;
  };
in {
  # Linux: install and configure
  programs.ghostty = pkgs.lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableFishIntegration = true;
    settings = ghosttyConfig;
  };

  # macOS: don't install, just write config
  xdg.configFile."ghostty/config.toml" = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
    text = pkgs.lib.generators.toTOML {} ghosttyConfig;
  };
}
