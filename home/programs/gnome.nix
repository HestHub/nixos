{pkgs, ...}: {
  home.sessionVariables.GTK_THEME = "Nordic";
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnome-tweaks
    gnomeExtensions.vitals
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Nordic-bluish";
      package = pkgs.nordic;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "pop-shell@system76.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "Vitals@CoreCoding.com"
        ];
      };
    };
  };
}
# https://github.com/nix-community/dconf2nix?tab=readme-ov-file

