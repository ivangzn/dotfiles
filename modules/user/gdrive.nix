{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rclone
    libnotify
  ];

  home.file."ivo/RCLONE_TEST".text = "";

  systemd.user.services."rclone-bisync-ivo" = {
    Unit = {
      Description = "Rclone Bisync ivo folder";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
      OnFailure = [ "rclone-notify-failure.service" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "rclone-bisync-ivo-runner" ''
        DIR="$HOME/ivo"
        TEST_FILE="$DIR/RCLONE_TEST"
        RCLONE="${pkgs.rclone}/bin/rclone"

        if [ ! -f "$TEST_FILE" ]; then
          ${pkgs.coreutils}/bin/mkdir -p "$DIR"
          ${pkgs.coreutils}/bin/touch "$TEST_FILE"
          exec $RCLONE bisync "$DIR" gdrive:/ivo --verbose --check-access --conflict-resolve newer --compare size,modtime --resilient --drive-use-trash --copy-links --resync
        else
          exec $RCLONE bisync "$DIR" gdrive:/ivo --verbose --check-access --conflict-resolve newer --compare size,modtime --resilient --drive-use-trash --copy-links
        fi
      ''}";
      StandardOutput = "journal";
      StandardError = "journal";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services."rclone-notify-failure" = {
    Unit = {
      Description = "Notify on rclone bisync failure";
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''${pkgs.libnotify}/bin/notify-send -u critical -a "Rclone Sync" "⚠️ Error en la sincronización" "Rclone falló al sincronizar ~/ivo con Google Drive.\nRevisa los logs con: journalctl --user -u rclone-bisync-ivo.service -e"'';
    };
  };

  systemd.user.timers."rclone-bisync-ivo" = {
    Unit = {
      Description = "Run Rclone Bisync every hour";
    };

    Timer = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
      Unit = "rclone-bisync-ivo.service";
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
