{
  pkgs,
  config,
  ...
}: let
  username = "hest";
  nvimPath = "${config.home.homeDirectory}/Dev/me/nixos/dotfiles/nvim";
  zellijPath = "${config.home.homeDirectory}/Dev/me/nixos/dotfiles/zellij";
in {
  imports = [
    ./core.nix
    ./programs/git.nix
    ./programs/k9s.nix
    ./programs/fish.nix
  ];

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
