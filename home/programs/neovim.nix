{
  pkgs,
  config,
  ...
}: let
  nvimPath = "${config.home.homeDirectory}/dev/me/nixos/dotfiles/nvim";
  link = subpath: config.lib.file.mkOutOfStoreSymlink "${nvimPath}/${subpath}";
in {
  # Symlink individual items so programs.neovim can still manage init.lua
  # force = true handles macOS where init.lua may already exist as a plain file
  xdg.configFile."nvim/init.lua".force = true;
  xdg.configFile."nvim/lua".source = link "lua";
  xdg.configFile."nvim/lazy-lock.json".source = link "lazy-lock.json";
  xdg.configFile."nvim/lazyvim.json".source = link "lazyvim.json";
  xdg.configFile."nvim/spell".source = link "spell";
  xdg.configFile."nvim/stylua.toml".source = link "stylua.toml";

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
