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
    };

    brews = [
      "mas"
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "lima-additional-guestagents"
      "colima"
      "mender-artifact"
    ];

    casks = [
      "alt-tab"
      "tailscale" # easier to manage
      "mqttx" # not available on arm
      "microsoft-teams" # old version only on nix
      "microsoft-auto-update"
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
