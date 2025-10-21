{
  pkgs,
  system,
  inputs,
  ...
}: {
  imports = [
    ./core.nix
    ./programs/ghostty.nix
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/markdown.nix
    ./programs/fancontrol-gui.nix
  ];

  home = {
    username = "hest";
    homeDirectory = "/home/hest";

    packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
      gcc
      radeontop
      lact
      tailscale
      keymapp
      wineWowPackages.waylandFull
      virtiofsd
      bitwarden
      wl-clipboard
      icu77
      sqlitebrowser
      easyeffects
    ];
  };
}
