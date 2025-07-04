{
  pkgs,
  inputs,
  config,
  ...
}: let
  username = "hest";
  nvimPath = "${config.home.homeDirectory}/Dev/me/nixos/dotfiles/nvim";
  zellijPath = "${config.home.homeDirectory}/Dev/me/nixos/dotfiles/zellij";
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
    inputs.sops-nix.homeManagerModules.sops
    ./core.nix
    (import ./programs/git.nix {inherit pkgs gitIncludes config;})
    ./programs/k9s.nix
    ./programs/ghostty.nix
    ./programs/fish.nix
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    secrets = {
      # private ssh
      "me/key".path = "${config.home.homeDirectory}/.ssh/id_me";
      "me/pub".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
      "me/config".path = "${config.home.homeDirectory}/.config/git/include_me";

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
  };

  xdg.enable = true;
  xdg.configHome = "/Users/${username}/.config";

  xdg.configFile."zellij".source = config.lib.file.mkOutOfStoreSymlink zellijPath;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;

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
      ollama
      socat
      minicom
      usbutils
    ];
  };
}
