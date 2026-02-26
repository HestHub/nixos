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

    packages = with pkgs; [
      kubectl
      dotnetPackages.Nuget
      wasmtime
      docker
      docker-credential-helpers
      inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
      zoom-us
      netcoredbg
      dotnet-sdk_10
      roslyn
      socat
      usbutils
      youtube-music
      blueutil
      pnpm
      typescript
      pgadmin4-desktopmode
      awscli2
      terraform
      minikube
      kubernetes-helm
      graphql-language-service-cli
      bicep-lsp
      (lib.lowPrio bicep-lsp)
      zulu25
    ];
  };
}
