{pkgs, ...}: {
  home.sessionVariables.GTK_THEME = "Nordic";
  home.packages = with pkgs; [
    gnomeExtensions.pop-shell
    gnome-tweaks
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-history
    gnomeExtensions.rounded-window-corners-reborn
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
          "clipboard-history@alexsaveau.dev"
        ];
      };
    };
  };
}
# https://github.com/nix-community/dconf2nix?tab=readme-ov-file
# gnome-extensions list
# to get UUID for installed extentions

