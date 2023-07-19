{ pkgs, lib, ... }:
let
  users = [ "sven" "susven" ];
in
{
  # Create Dir
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";

  # Copy items
  system.activationScripts = {
    copySkelDir = {
      text = ''
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=$user:users /etc/skel/ /home/$user/ && touch /home/$user/.skel.lock
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          ${pkgs.rsync}/bin/rsync -a --chmod=744 --chown=root:root /etc/skel/ /root/ && touch /root/.skel.lock
        fi
      '';
    };
  };
}
