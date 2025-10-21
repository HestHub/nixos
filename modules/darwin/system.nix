{
  pkgs,
  lib,
  ...
}: let
  hostname = "mbp";
  username = "hest";
in {
  nix = {
    enable = true;
    settings.trusted-users = ["root" username];
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 1w";
    };

    optimise.automatic = true;
  };
  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;
  networking.computerName = hostname;
  system = {
    defaults.smb.NetBIOSName = hostname;
    primaryUser = "hest";

    ###################################################################################
    #  macOS's System configuration
    #
    #  All the configuration options are documented here:
    #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
    #  and see the source code of this project to get more undocumented options:
    #    https://github.com/rgcr/m-cli
    ###################################################################################

    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    #activationScripts.postUserActivation.text = ''
    # activateSettings -u will reload the settings from the database and apply them to the current session,
    # so we do not need to logout and login again to make the changes take effect.
    #  /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    #'';

    keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`
      remapCapsLockToEscape = true; # remap caps lock to escape, useful for vim users
      swapLeftCommandAndLeftAlt = false;
    };

    defaults = {
      dock = {
        autohide = true;
        show-recents = false; # disable recent apps
        static-only = true;
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = false; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      trackpad = {
        Clicking = true; # enable tap to click()
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = false; # enable three finger drag
      };

      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = false; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key

        "com.apple.keyboard.fnState" = true; # enable function keys
        AppleInterfaceStyle = "Dark"; # dark mode
        AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = false; # enable press and hold

        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 3; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false; # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction(自动拼写检查)
        NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;
        _HIHideMenuBar = true; # hide menu bar
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = true;
        };
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      loginwindow = {
        GuestEnabled = false; # disable guest user
        SHOWFULLNAME = true; # show full name in login window
      };
    };
  };

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    shell = "/etc/profiles/per-user/hest/bin/fish";
  };

  programs.fish.enable = true;
  environment.shells = [
    pkgs.fish
  ];
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      fira-code
    ];
  };
}
