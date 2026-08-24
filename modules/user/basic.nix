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