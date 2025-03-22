{pkgs, ...}: {
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnome-tweaks
  ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "pop-shell@system76.com"
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
        ];
      };
    };
  };
}
# https://github.com/nix-community/dconf2nix?tab=readme-ov-file

