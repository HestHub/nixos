{pkgs, ...}: let
  username = "hest";
in {
  imports = [
    ./programs/core.nix
  ];

  xdg.enable = true;
  xdg.configHome = "/Users/${username}/.config";

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
