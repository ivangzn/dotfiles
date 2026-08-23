{ config, pkgs, dotfiles, ... }: 

let 
  vscodeDir = "${dotfiles.dir}/vscode";
in 
{
  programs.antigravity-cli = {
    enable = true;
  };

  programs.go = {
    enable = true;
  };

  programs.npm = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      alias = {
        lg = "log --oneline";
      };
    };
  };

  # Visual Studio Code
  programs.vscode = {
    enable = true;
  };

  home.file.".config/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${vscodeDir}/keybindings.json";
  home.file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${vscodeDir}/settings.json";

  # terminal tweaks
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      d = "cd ~/repos";
      a = "antigravity-ide";
      gsync = "systemctl --user start rclone-bisync-ivo.service";
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#ivo-nixos";
    };
  };

  programs.starship = {
    enable = true;
  };

  home.file.".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/alacritty"; # style
}