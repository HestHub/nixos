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

  programs.ripgrep.enable = true;
  programs.home-manager.enable = true;
}
