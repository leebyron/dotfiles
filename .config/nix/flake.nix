# Rebuild system with
#
# darwin-rebuild switch --flake ~/.config/nix

{
  description = "leebyron darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle }:
  let
    configuration = { pkgs, ... }: {
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Allow all software
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        arc-browser
        git
        gnupg
        neovim
        nixd  # Language server for nix
        pinentry_mac
        prettierd
        raycast
        zed-editor
      ];

      fonts.packages = with pkgs; [
        fira-code
        (fetchzip {
          url = "https://github.com/leebyron/lode/releases/download/v0.3/Lode-v0.3.zip";
          sha256 = "sha256-DcL3Y98vbM63MLdQoD20Jy4ekcJJKFQPNig10uQW3FY=";
          stripRoot = false;
        })
      ];

      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          # cleanup = "uninstall";
          upgrade = true;
        };
        taps = [];
        brews = [];
        casks = [
          "karabiner-elements"
          "1password"  # TODO: move into nix when the flake is fixed
          "ghostty"  # TODO: move into nix when the flake is fixed
        ];
      };

      system.defaults = {
        ActivityMonitor.ShowCategory = 101;  # All Hierarchally
        dock = {
          autohide = true;
          autohide-delay = 0.0;
          expose-animation-duration = 0.1;
          mru-spaces = false;
          scroll-to-open = true;
          static-only = true;
          tilesize = 32;
          wvous-br-corner = 1;  # Disables OS default Quick Note
        };
        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";  # Search current folder
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "Nlsv";  # List view
          _FXShowPosixPathInTitle = true;
          _FXSortFoldersFirst = true;
          NewWindowTarget = "Home";
          ShowStatusBar = true;
        };
        LaunchServices.LSQuarantine = false;  # Disable "This app was downloaded" dialogs
        loginwindow.GuestEnabled = false;
        screencapture = {
          location = "$HOME/Screenshots";
          show-thumbnail = false;
          type = "png";
        };
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          ApplePressAndHoldEnabled = false;
          InitialKeyRepeat = 10;
          KeyRepeat = 1;
          NSWindowShouldDragOnGesture = true;
          PMPrintingExpandedStateForPrint = true;
          "com.apple.sound.beep.feedback" = 0;
        };
        WindowManager.EnableStandardClickToShowDesktop = false;
        CustomSystemPreferences = {
          "com.apple.AdLib" = {
            allowApplePersonalizedAdvertising = false;
          };
          "com.apple.SoftwareUpdate" = {
            AutomaticCheckEnabled = true;
            # Check for software updates daily, not just once per week
            ScheduleFrequency = 1;
            # Download newly available updates in background
            AutomaticDownload = 1;
            # Install System data files & security updates
            CriticalUpdateInstall = 1;
          };
        };
      };

    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#zeno
    darwinConfigurations."zeno" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "leebyron";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            mutableTaps = false;
          };
        }
      ];
    };
  };
}