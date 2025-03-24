{
  config,
  ...
}: let
  nvimPath = "${config.home.homeDirectory}/Dev/nixos/dotfiles/nvim";
in {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink nvimPath;
}
