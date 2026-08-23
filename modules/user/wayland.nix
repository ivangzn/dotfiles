{ config, pkgs, dotfiles, ... }:

{
  # Niri
  home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/niri";

  # Noctalia shell
  home.file.".config/noctalia/".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/noctalia";
  home.file.".local/state/noctalia/settings.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/noctalia/settings.toml";
}