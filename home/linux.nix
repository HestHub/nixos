{
  pkgs,
  system,
  inputs,
  ...
}: {
  imports = [
    ./core.nix
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/gnome.nix
  ];

  home.username = "hest";
  home.homeDirectory = "/home/hest";

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    gcc
    radeontop
    lact
    tailscale
    keymapp
    wineWowPackages.waylandFull
    virtiofsd
    bitwarden
    xclip

    # LSPs
    go
    python314
    lua
    vtsls
    unzip
    nodejs
    nil
    pkgs.dotnetCorePackages.dotnet_9.sdk
  ];
}
