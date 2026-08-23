{ config, pkgs, ... }:

{
  # Steam installation & configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports for local transfer
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    lutris
    mangohud
    goverlay
  ];

  # Enable GameMode (provides `gamemoderun` and system optimizations for games)
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
      gpu = {
        apply_gpu_optimizations = "accept-responsibility";
        nv_powermizer_mode = 1;
      };
    };
  };

  # System service for LACT (Linux AMD/NVIDIA Control Tool)
  services.lact = {
    enable = true;
  };
}