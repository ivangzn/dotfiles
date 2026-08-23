{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    noctalia
    wl-clipboard
    nautilus
    alacritty
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
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