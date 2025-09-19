{pkgs, ...}: {
  programs.sketchybar = {
    enable = true;
    service = {
      enable = true;
      errorLogFile = /tmp/sketchyerr;
      outLogFile = /tmp/sketchylog;
    };
    configType = "lua";
    luaPackage = pkgs.lua5_4;
    sbarLuaPackage = pkgs.sbarlua;
    config = {
      source = ../../dotfiles/sketchybar;
      recursive = true;
    };
  };
}
