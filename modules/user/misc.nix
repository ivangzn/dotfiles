{ config, pkgs, dotfiles, ... }:

{
  programs.obsidian = {
    enable = true;
  };

  programs.onlyoffice = {
    enable = true;
  };

  programs.vesktop = {
    enable = true;
  };
  home.file.".config/vesktop/themes".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/vesktop/themes";

  programs.anki = {
    enable = true;
  };
}