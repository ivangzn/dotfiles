{ config, pkgs, ...}:

let
  handbrake-nvenc = pkgs.handbrake.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.autoAddDriverRunpath ];
  });
in
{
  environment.systemPackages = with pkgs; [
    handbrake-nvenc
    kdePackages.kdenlive
  ];
}