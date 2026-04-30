{pkgs, ...}: {
  environment.variables.EDITOR = "nvim";

  # services.tailscale.enable = true;

  environment.systemPackages = [pkgs.aerospace];
  launchd.user.agents.aerospace = {
    serviceConfig = {
      ProgramArguments = ["${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace"];
      RunAtLoad = true;
      KeepAlive = true;
    };
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
    taps = [
      "junian/homebrew-dotnet"
    ];

    brews = [
      "mas"
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "media-control"
      "azure-cli"
      "mikesmithgh/homebrew-git-prompt-string/git-prompt-string"
      "coursier"
      "util-linux"
      "librdkafka"
    ];

    casks = [
      "alt-tab"
      "mqttx" # not available on arm
      "raycast" # todo
      "db-browser-for-sqlite"
      "sanesidebuttons"
      "steam"
      "dotnet-sdk@10.0"
      "dotnet-sdk@8.0"
      "ghostty"
      "font-sketchybar-app-font"
    ];
  };
}
