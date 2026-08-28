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
    noto-fonts-color-emoji
  ];

  # Maintenance
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
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