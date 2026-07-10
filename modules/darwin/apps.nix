{pkgs, ...}: {
  environment.variables.EDITOR = "nvim";

  # services.tailscale.enable = true;

  environment.systemPackages = [pkgs.aerospace];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };

    masApps = {
      # mas is flaky on fresh installs — install these manually from the App Store
      # Keynote = 409183694;
      # MonitorControl-Lite = 1595464182;
      # Amphetamine = 937984704;
      # Numbers = 409203825;
      # Tailscale = 1475387142;
    };
    taps = [];

    brews = [
      "mas"
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "media-control"
      "mikesmithgh/homebrew-git-prompt-string/git-prompt-string"
      "coursier"
      "util-linux"
      "librdkafka"
    ];

    casks = [
      "alt-tab"
      "db-browser-for-sqlite"
      "sanesidebuttons"
      "steam"
      "ghostty"
      "raycast"
    ];
  };
}
