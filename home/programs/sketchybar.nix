{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    extraPackages = [pkgs.jq];
  };

  home.file.".config/sketchybar" = {
    source = ../../dotfiles/sketchybar;
    recursive = true;
  };

  home.activation.sketchybar = lib.hm.dag.entryAfter ["writeBoundary"] "${pkgs.sketchybar}/bin/sketchybar --reload";
}
