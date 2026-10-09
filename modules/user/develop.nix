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

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };

  home.packages = with pkgs; [
    # Go
    gcc
    gopls
    gotools
    delve
    # Java
    (jdt-language-server.override { jdk = pkgs.jdk25; })
    gradle
    maven
  ];

  home.sessionPath = [
    "$HOME/go/bin"
  ];

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

  programs.delta = {
    enable = true;
    options = {
      line-numbers = true;
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    extraConfig = ''
      set -as terminal-features ',*:RGB'
      set -as terminal-overrides ',*:Tc'
    '';
  };

  programs.helix = {
    enable = true;
  };

  home.file.".config/helix".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles.dir}/helix";

  # Visual Studio Code
  programs.vscode = {
    enable = true;
  };

  home.file.".config/Code/User/keybindings.json".source = config.lib.file.mkOutOfStoreSymlink "${vscodeDir}/keybindings.json";
  home.file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${vscodeDir}/settings.json";

  # Databases
  programs.dbeaver = {
    enable = true;
  };

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

  # Commands
  programs.ripgrep = {
    enable = true;
  };
}
