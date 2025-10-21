{...}: {
  imports = [
    #./yabai.nix
  ];
  environment.variables.EDITOR = "nvim";

  services.tailscale.enable = true;

  services.aerospace = {
    enable = true;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    masApps = {
      Keynote = 409183694;
      MonitorControl-Lite = 1595464182;
      Amphetamine = 937984704;
      Numbers = 409203825;
      Tailscale = 1475387142;
    };

    brews = [
      "mas"
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "lima-additional-guestagents"
      "colima"
      "mender-artifact"
      "media-control"
      "azure-cli"
    ];

    casks = [
      "alt-tab"
      "mqttx" # not available on arm
      "raycast" # todo
      "sanesidebuttons"
      "steam"
      "keymapp"
      "krita"
      "ghostty"
      "font-sketchybar-app-font"
    ];
  };
}
