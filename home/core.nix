{
  config,
  pkgs,
  system,
  inputs,
  ...
}: {
  imports = [
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/mise.nix
    ./programs/gnome.nix
  ];
  home.username = "hest";
  home.homeDirectory = "/home/hest";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default

    gcc
    # CLI
    jq
    yq
    lf
    bat
    eza
    fzf
    zellij
    tre-command
    radeontop
    xclip
    neofetch
    cargo

    # basics
    wget
    vim

    # gpu controller
    lact

    # pw-manager
    bitwarden

    # coms
    discord
    slack

    # media
    supersonic
    spotube

    # containers
    docker-compose

    # Emulation
    wineWowPackages.waylandFull # windows
    virtiofsd

    # dev
    git
    gh
    mise

    # VPN
    tailscale

    # zsa keymapper for moonlander
    keymapp

    # Nix
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

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
