{ config, pkgs, dotfiles, ... }:

{
  # Desktop std stuff
  xdg = {
    # some apps might crash or not work properly without these dirs
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  services.polkit-gnome = {
    enable = true;
  };

  services.udiskie = {
    enable = true;
  };

  # Language
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true; # Crucial for Niri / Wayland
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  # Set Super+Space as the toggle hotkey
  xdg.configFile."fcitx5/config".text = ''
    [Hotkey]
    TriggerKeys=
    0=Super+space

    [Hotkey/TriggerKeys]
    0=Super+space
  '';

  # Set your active layout profile
  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=latam
    DefaultIM=mozc

    [Groups/0/Items/0]
    Name=keyboard-latam
    Layout=

    [Groups/0/Items/1]
    Name=mozc
    Layout=

    [GroupOrder]
    0=Default
  '';

  # Dark theme
  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk3.colorScheme = "dark";
    gtk4.colorScheme = "dark";
    
    theme = { name = "Adwaita-dark"; package = pkgs.gnome-themes-extra; };
    iconTheme = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };
  };

  # Cursor
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # Security
  programs.keepassxc = {
    enable = true;
  };

  # Video
  programs.mpv = {
    enable = true;
    config = {
      keep-open = true;
    };
  };
}