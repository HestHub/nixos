{
  pkgs,
  config,
  ...
}: let
  projectRoot = "${config.home.homeDirectory}/dev/me/nixos";
  nvimPath = "${projectRoot}/dotfiles/nvim";
  link = subpath: config.lib.file.mkOutOfStoreSymlink "${nvimPath}/${subpath}";
in {
  xdg = {
    configFile = {
      "nvim/init.lua".force = true;
      "nvim/lua".source = link "lua";
      "nvim/lazy-lock.json".source = link "lazy-lock.json";
      "nvim/lazyvim.json".source = link "lazyvim.json";
      "nvim/spell".source = link "spell";
      "nvim/stylua.toml".source = link "stylua.toml";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;
    # Provider-disabling lines are prepended by the module; this is the rest of init.lua
    initLua = ''
      -- bootstrap lazy.nvim, LazyVim and your plugins
      require("config.lazy")
    '';
    extraWrapperArgs = with pkgs; [
      # LIBRARY_PATH is used by gcc before compilation to search directories
      # containing static and shared libraries that need to be linked to your program.
      "--suffix"
      "LIBRARY_PATH"
      ":"
      "${lib.makeLibraryPath [stdenv.cc.cc zlib]}"

      # PKG_CONFIG_PATH is used by pkg-config before compilation to search directories
      # containing .pc files that describe the libraries that need to be linked to your program.
      "--suffix"
      "PKG_CONFIG_PATH"
      ":"
      "${lib.makeSearchPathOutput "dev" "lib/pkgconfig" [stdenv.cc.cc zlib]}"
    ];
  };
}
