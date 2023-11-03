{ pkgs, lib, config, themeMode, ... }:
let
  users = [ "sven" ];
in
{
  environment.etc.skel.source = ../../skel/template-${themeMode};

  # Create Dir
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";

  # Copy items
  system.activationScripts = {
    copySkelDir = {
      text = ''
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=$user:users -I /etc/skel/ /home/$user/ && touch /home/$user/.skel.lock || echo "Please Reboot that skel get applyed!"
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=root:root -I /etc/skel/ /root/ && touch /root/.skel.lock
        fi
      '';
    };
    copyThemeDir = {
      text = ''
        for user in ${toString users}; do
          ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=$user:users --copy-links -I /run/current-system/sw/share/themes/ /home/$user/.themes
        done
        ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=root:root --copy-links -I /run/current-system/sw/share/themes/ /root/.themes
      '';
    };
  };
}