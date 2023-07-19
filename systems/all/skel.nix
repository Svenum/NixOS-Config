{ pkgs, lib, ... }:
let
  users = [ "sven" "susven" ];
in
{
  # Create Dir
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";
  environment.etc.skel.mode = "0600";

  # Copy items
  system.activationScripts = {
    copySkelDir = {
      text = ''
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            cp -rpf /etc/skel/. /home/$user/ && touch /home/$user/.skel.lock
            chown -R $user:users /home/$user/
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          cp -rpf /etc/skel/. /root/ && touch /root/.skel.lock
        fi
      '';
    };
  };
}
