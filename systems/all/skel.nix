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
            cp -rf /etc/skel/. /home/$user/ && touch /home/$user/.skel.lock
            mkdir -p /home/$user/Downloads \
                     /home/$user/Documents \
                     /home/$user/Videos \
                     /home/$user/Pictures \
                     /home/$user/Games
            echo "
              [Desktop Entry]
              Icon=folder-games
            " > /home/$user/Games/.directory
            chown -R $user:users /home/$user/
            chmod -R 755 /home/$user/
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          cp -rf /etc/skel/. /root/ && touch /root/.skel.lock
          chmod -R 755 /root/
        fi
      '';
    };
  };
}
