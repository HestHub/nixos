{pkgs, ...}: {
  imports = [
    ./programs/core.nix
  ];
  home.packages = with pkgs; [
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
  ];
}
