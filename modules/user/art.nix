{ config, pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture
      wlrobs
      obs-pipewire-audio-capture
    ];
  };
}