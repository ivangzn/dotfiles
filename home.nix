{ config, pkgs, ...}:

{
  imports = [
    ./modules/user/basic.nix
    ./modules/user/develop.nix
    ./modules/user/gdrive.nix
    ./modules/user/wayland.nix
    ./modules/user/art.nix
  ];

  home.stateVersion = "26.05";
}