{
  pkgs,
  inputs,
  config,
  ...
}: let
  projectRoot = "${config.home.homeDirectory}/dev/me/nixos";
  zellijPath = "${projectRoot}/dotfiles/zellij";
  aerospacePath = "${projectRoot}/dotfiles/aerospace";
  starshipPath = "${projectRoot}/dotfiles/starship";
in {
  imports = [
    ./programs/colima.nix
    ./programs/devpod.nix
    ./programs/ssh-config.nix
    ./programs/neovim.nix
    inputs.sops-nix.homeManagerModules.sops
    ./programs/git.nix
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    secrets = {
      "me/key".path = "${config.home.homeDirectory}/.ssh/id_me";
      "me/pub".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
      "me/config".path = "${config.home.homeDirectory}/.config/git/include_me";
    };
  };
  xdg = {
    enable = true;
    configFile = {
      "zellij".source = config.lib.file.mkOutOfStoreSymlink zellijPath;
      "aerospace".source = config.lib.file.mkOutOfStoreSymlink aerospacePath;
      "starship".source = config.lib.file.mkOutOfStoreSymlink starshipPath;
    };
  };

  home.packages = with pkgs; [
    # tools
    age
    # devenv
    devpod
    fzf
    git
    gitleaks
    jq
    just
    #nushell
    skopeo
    sops
    starship
    tldr
    tre-command
    trufflehog
    unixtools.watch
    unzip
    watchexec
    wget

    # TUI
    lazydocker
    lazygit
    yazi
    zellij
    claude-code
    gemini-cli

    # GUI
    discord
    slack

    # LSPS
    alejandra
    cargo-nextest
    deadnix
    statix
    go
    lua
    nil
    nodejs_24
    python314
    rustup
    vtsls
  ];

  home.stateVersion = "25.05";
  programs = {
    diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
    };
    # direnv = {
    #   enable = true;
    #   nix-direnv.enable = true;
    #   silent = true;
    #   config = {
    #     hide_env_diff = true;
    #     log_format = "";
    #     global.load_dotenv = true;
    #   };
    # };

    bat = {
      enable = true;
      config = {
        theme = "Nord";
        style = "numbers,changes,header";
      };
    };

    eza = {
      enable = true;
      git = true;
      icons = "auto";
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    starship = {
      enable = true;
      enableTransience = true;
    };
    ripgrep.enable = true;
    home-manager.enable = true;
  };
}
