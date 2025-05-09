{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      fira-code
    ];
  };

  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;

    # Enable the GNOME Desktop Environment.
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;

    # autologin without password
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "hest";

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "intl";
    };

    # enable tailscale VPN
    tailscale.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware = {
    # enable zsa udev rules
    keyboard.zsa.enable = true;
  };

  security.rtkit.enable = true;

  # Define a user account.
  users.users.hest = {
    isNormalUser = true;
    description = "hest";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  systemd = {
    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    services.NetworkManager-wait-online.enable = false;

    # lact AMD GPU controller
    services.lact = {
      description = "AMDGPU Control Daemon";
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
      };
      enable = true;
    };
  };

  # enable containerization ( docker )
  virtualisation = {
    containers.enable = true;
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  programs = {
    virt-manager.enable = true;
    steam = {
      enable = true;
    };
    fish.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.gnome.excludePackages = with pkgs; [
    geary # email client
    seahorse # password manager
    yelp # help tool
    evince # document viewer
    gnome-weather
    gnome-maps
    gnome-music
    gnome-photos
    gnome-calendar
    gnome-contacts
    gnome-music
    simple-scan # document scanner
    cheese # web cam
    gnome-clocks
    gnome-tour
    gnome-connections # remote desktop
    epiphany # web browser
    totem # video player
    gnome-system-monitor
  ];
  # use fhs to run non nix binaries
  # fhs shell
  environment.systemPackages = with pkgs; [
    (let
      base = pkgs.appimageTools.defaultFhsEnvArgs;
    in
      pkgs.buildFHSEnv (base
        // {
          name = "fhs";
          targetPkgs = pkgs:
            (base.targetPkgs pkgs)
            ++ (
              with pkgs; [
                pkg-config
                ncurses
              ]
            );
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = ["dev"];
        }))
  ];
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      icu
    ];
  };

  nix = {
    settings.trusted-users = ["root" "hest"];
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = "22:22";
      options = "--delete-older-than +3";
    };

    settings.auto-optimise-store = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
