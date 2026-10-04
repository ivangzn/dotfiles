{ config, pkgs, dotfiles, ... }:

{
  # MangoHud
  home.file.".config/MangoHud".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/mangohud";
}
