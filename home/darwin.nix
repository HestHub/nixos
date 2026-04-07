{
  pkgs,
  config,
  inputs,
  ...
}: let
  username = "hest";
in {
  imports = [
    ./core.nix
    ./programs/k9s.nix
    ./programs/ghostty.nix
    ./programs/fish.nix
    ./programs/sketchybar.nix
  ];

  sops.secrets = {
    # c... ssh
    "c/key".path = "${config.home.homeDirectory}/.ssh/id_c";
    "c/pub".path = "${config.home.homeDirectory}/.ssh/id_c.pub";
    "c/config".path = "${config.home.homeDirectory}/.config/git/include_c";

    # c... ssh
    "g/key".path = "${config.home.homeDirectory}/.ssh/id_g";
    "g/pub".path = "${config.home.homeDirectory}/.ssh/id_g.pub";
    "g/config".path = "${config.home.homeDirectory}/.config/git/include_g";

    "nuget".path = "${config.home.homeDirectory}/.config/nuget/nuget.config";
  };

  home = {
    username = "${username}";
    homeDirectory = "/Users/${username}";
    sessionVariables = {
      DOCKER_HOST = "unix://${config.home.homeDirectory}/.config/colima/default/docker.sock";
    };

    packages = with pkgs; [
      # GUI
      inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
      pgadmin4-desktopmode
      pear-desktop
      zoom-us

      # LSP
      (lib.lowPrio bicep-lsp)
      bicep-lsp
      graphql-language-service-cli
      roslyn
      typescript
      wasmtime
      zulu25

      # Tools
      blueutil
      colima
      docker-client
      docker-credential-helpers
      kubectl
      kubernetes-helm
      lima-additional-guestagents
      minikube
      socat
      terraform
      usbutils
      usbutils

      # TuI
      claude-code
    ];
  };
}
