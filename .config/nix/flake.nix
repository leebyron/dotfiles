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
      nix.settings = {
        experimental-features = "nix-command flakes";
        use-xdg-base-directories = true;
      };
      # https://github.com/LnL7/nix-darwin/issues/943
      environment.profiles = pkgs.lib.mkOrder 700 [ "\$HOME/.local/state/nix/profile" ];

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
        as-tree
        bat
        cmake
        coreutils
        curl
        fd
        fnm
        fzf
        gh
        git
        gnupg
        neovim
        nixd  # Language server for nix
        pinentry_mac
        prettierd
        pure-prompt
        qmk
        raycast
        ripgrep
        ttfautohint
        zed-editor
        zoom-us
        zsh
      ];

      fonts.packages = with pkgs; [
        fira-code
        inter
        ibm-plex
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
          # TODO: move these into nix when their flakes are fixed
          "1password"
          "ghostty"
          "caffeine"
        ];
      };

      # https://specifications.freedesktop.org/basedir-spec/latest/#variables
      environment.variables = rec {
        XDG_CACHE_HOME  = "$HOME/Library/Caches";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_STATE_HOME  = "$HOME/.local/state";
        XDG_RUNTIME_DIR = "/tmp/$USER";
        PATH = [ "$HOME/.local/bin" "$PATH" ];
        # configure programs which do not yet follow XDG
        ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
        HISTFILE = "${XDG_STATE_HOME}/zsh/history";
        GNUPGHOME = "${XDG_CONFIG_HOME}/gnupg";
        LESSHISTFILE = "${XDG_STATE_HOME}/less/history";
        NPM_CONFIG_USERCONFIG = "${XDG_CONFIG_HOME}/npm/config";
        NPM_CONFIG_CACHE = "${XDG_CACHE_HOME}/npm";
        NPM_CONFIG_TMP = "${XDG_RUNTIME_DIR}/npm";
        NODE_REPL_HISTORY = "${XDG_STATE_HOME}/node/repl_history";
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
          CreateDesktop = false;  # https://leebyron.com/til/remove-mac-desktop/
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
          location = "~/Screenshots";
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

      system.activationScripts.postUserActivation.text = ''
        # Create referenced directories if they don't exist
        mkdir -p "$HOME/Screenshots" "$(dirname "$HISTFILE")" "$(dirname "$NODE_REPL_HISTORY")"
        # Set the desktop wallpaper
        osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
        # https://leebyron.com/til/remove-mac-desktop/
        if [ ! -L "$HOME/Desktop" ]; then
          sudo rm -rf "$HOME/Desktop"
          ln -s "$HOME" "$HOME/Desktop"
          sudo chflags -h schg ~/Desktop
        fi
      '';

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
