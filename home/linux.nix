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

    go
    python314
    lua
  ];
}
