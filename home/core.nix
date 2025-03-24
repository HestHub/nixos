{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    cargo
    cargo-nextest
    discord
    fzf
    gh
    git
    gotop
    jq
    just
    lazydocker
    lazygit
    lf
    nushell
    slack
    tldr
    tre-command
    unixtools.watch
    watchexec
    wget
    zellij
  ];

  home.stateVersion = "25.05";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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

  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";
      style = "numbers,changes,header";
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  programs.zoxide = {
    enable = true;
  };

  ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.ripgrep.enable = true;
  programs.home-manager.enable = true;
}
