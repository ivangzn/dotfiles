{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    btop
    firefox
    fastfetch
    ncdu
    baobab
    gparted-full
    gnome-calculator
    vlc
    trash-cli
    qimgv

    # Audio
    pavucontrol
    qpwgraph

    # Extra
    inputs.gslapper.packages.${stdenv.hostPlatform.system}.gslapper
    socat
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  # Maintenance
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Other apps
  services.flatpak = {
    enable = true;
  };

  # Realtime scheduling for low-latency & dropout-free audio
  security.rtkit.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Hi-Res audio sample rates & quantum buffer configuration
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
          "default.clock.min-quantum" = 1024;
        };
      };
    };

    # Disable node auto-suspend to prevent popping/clicking
    wireplumber.extraConfig = {
      "10-disable-suspend" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "node.name" = "~alsa_output.*"; } ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # Login
  services.displayManager.sddm = {
    enable = true;
  };

  security.polkit.enable = true;

  # Automounting
  services.udisks2 = {
    enable = true;
  };

  # Appimages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
