{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    wget
    git
    gh
    tre-command
    tldr
    unixtools.watch
    lf
    fzf
    zellij
    watchexec
    cargo
    cargo-nextest
    lazydocker
    gotop
    discord
    slack
    alejandra
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
