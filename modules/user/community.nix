{ config, pkgs, dotfiles, inputs, ... }:

{
  home.packages = [
    inputs.hytale-launcher.packages.${pkgs.system}.default
  ];
}
