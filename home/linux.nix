{
  pkgs,
  system,
  inputs,
  config,
  ...
}: let
  gitIncludes = [
    {
      condition = "gitdir:~/dev/";
      path = "${config.home.homeDirectory}/.config/git/include_me";
    }
  ];
in {
  imports = [
    ./core.nix
    ./programs/ghostty.nix
    (import ./programs/git.nix {inherit pkgs gitIncludes config;})
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/markdown.nix
  ];

  sops.secrets = {
    # private ssh
    "me/key".path = "${config.home.homeDirectory}/.ssh/id_me";
    "me/pub".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
    "me/config".path = "${config.home.homeDirectory}/.config/git/include_me";
  };

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
