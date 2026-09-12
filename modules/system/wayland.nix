{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    noctalia
    wl-clipboard
    nautilus
    alacritty
    inputs.nixpkgs-xwayland.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite
    playerctl
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
  };

  systemd.user.services.noctalia = {
    serviceConfig = {
      TimeoutStopSec = "2s";
    };
  };

  services.displayManager.sddm = {
    wayland.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}