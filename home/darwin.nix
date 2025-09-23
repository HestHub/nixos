{
  pkgs,
  inputs,
  config,
  ...
}: let
  username = "hest";
  gitIncludes = [
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
  ];
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
      kubelogin
      postman
      zoom-us
      awscli
      azure-cli
      aider-chat
      mono
      netcoredbg
      omnisharp-roslyn
      socat
      minicom
      usbutils
      youtube-music
    ];
  };
}
