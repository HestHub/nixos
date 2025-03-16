{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnome-tweaks
  ];
}
