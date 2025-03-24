{
  pkgs,
  system,
  inputs,
  config,
  ...
}: let
  nvimPath = "${config.home.homeDirectory}/Dev/nixos/dotfiles/nvim";
  zellijPath = "${config.home.homeDirectory}/Dev/nixos/dotfiles/zellij";
in {
  imports = [
    ./core.nix
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/gnome.nix
  ];

  xdg.configFile."zellij".source = config.lib.file.mkOutOfStoreSymlink zellijPath;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;

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
  };
}
