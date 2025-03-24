{
  pkgs,
  lib,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;

  programs.nix-index.enable = true;

  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 1w";
  };

  nix.optimise.automatic = true;
}
