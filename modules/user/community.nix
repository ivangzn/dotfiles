{ config, pkgs, dotfiles, inputs, ... }:

{
  home.packages = [
    inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
