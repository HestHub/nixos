{
  pkgs,
  system,
  inputs,
  config,
  ...
}: let
  nvimPath = "${config.home.homeDirectory}/dev/nixos/dotfiles/nvim";
  zellijPath = "${config.home.homeDirectory}/dev/nixos/dotfiles/zellij";
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
    (import ./programs/git.nix {inherit pkgs gitIncludes;})
    ./programs/fish.nix
    ./programs/gnome.nix
    ./programs/markdown.nix
    ./programs/walker.nix
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.dot-secrets}/secrets.yaml";
    secrets = {
      # private ssh
      "me/key".path = "${config.home.homeDirectory}/.ssh/id_me";
      "me/pub".path = "${config.home.homeDirectory}/.ssh/id_me.pub";
      "me/config".path = "${config.home.homeDirectory}/.config/git/include_me";
    };
  };

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
      wl-clipboard
      icu77
    ];
  };
}
