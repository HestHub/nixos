{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  projectRoot = "${config.home.homeDirectory}/dev/me/nixos";
  nvimPath = "${projectRoot}/dotfiles/nvim";
  zellijPath = "${projectRoot}/dotfiles/zellij";
  aerospacePath = "${projectRoot}/dotfiles/aerospace";
  starshipPath = "${projectRoot}/dotfiles/starship";
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    (import ./programs/git.nix {
      inherit pkgs config;
      gitIncludes =
        if pkgs.stdenv.isDarwin
        then [
          {
            condition = "gitdir:~/dev/me/";
            path = "${config.home.homeDirectory}/.config/git/include_me";
          }
          {
            condition = "gitdir:~/dev/c*/";
            path = "${config.home.homeDirectory}/.config/git/include_c";
          }
          {
            condition = "gitdir:~/dev/g*/";
            path = "${config.home.homeDirectory}/.config/git/include_g";
          }
        ]
        else [
          {
            condition = "gitdir:~/dev/";
            path = "${config.home.homeDirectory}/.config/git/include_me";
          }
        ];
    })
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    secrets = {
      "me/key".path = "${config.home.homeDirectory}/.ssh/id_me";
      "me/pub".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
      "me/config".path = "${config.home.homeDirectory}/.config/git/include_me";
      "gemini" = {};
    };
  };
  xdg = {
    enable = true;
    configFile = {
      "zellij".source = config.lib.file.mkOutOfStoreSymlink zellijPath;
      "nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
      "aerospace".source = config.lib.file.mkOutOfStoreSymlink aerospacePath;
      "starship".source = config.lib.file.mkOutOfStoreSymlink starshipPath;
    };
  };

  home.packages = with pkgs; [
    # tools
    age
    devenv
    devpod
    fzf
    git
    gitleaks
    jq
    just
    nushell
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

    # GUI
    discord
    slack

    # LSPS
    alejandra
    cargo-nextest
    deadnix
    go
    lua
    nil
    nodejs_20
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
      config = {
        hide_env_diff = true;
        log_format = "";
        global.load_dotenv = true;
      };
    };

    neovim = {
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
  home.file.".ssh/config_nix".text = ''
    Host *.devpod
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null
      LogLevel ERROR

    Host *
      ForwardAgent no
      AddKeysToAgent yes
      Compression no
      ServerAliveInterval 0
      ServerAliveCountMax 3
      HashKnownHosts no
      UserKnownHostsFile ~/.ssh/known_hosts
      ControlMaster no
      SetEnv TERM=xterm-256color
      ControlPath ~/.ssh/master-%r@%n:%p
      ControlPersist no
  '';
  home.activation.setupMutableSSH = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    touch "$HOME/.ssh/config"
    chmod 600 "$HOME/.ssh/config"

    if ! grep -q "Include ~/.ssh/config_nix" "$HOME/.ssh/config"; then
      # Write the Include to a temp file, append the existing DevPod config, and replace
      echo "Include ~/.ssh/config_nix" > "$HOME/.ssh/config.tmp"
      cat "$HOME/.ssh/config" >> "$HOME/.ssh/config.tmp"
      mv "$HOME/.ssh/config.tmp" "$HOME/.ssh/config"
      chmod 600 "$HOME/.ssh/config"
    fi
  '';
}
