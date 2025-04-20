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
  ];
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./core.nix
    (import ./programs/git.nix {inherit pkgs gitIncludes;})
    ./programs/k9s.nix
    ./programs/fish.nix
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    secrets = {
      # private ssh
      "me/ssh_private".path = "${config.home.homeDirectory}/.ssh/id_me";
      "me/ssh_public".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
      "me/ssh_config".path = "${config.home.homeDirectory}/.config/git/include_me";
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
      tinygo
      wasmtime
      docker
      colima
      docker-credential-helpers
      kubelogin
      postman
      zoom-us
      supersonic
      spotube
      awscli
    ];
  };
}
