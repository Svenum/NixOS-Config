{ pkgs, ... }:
let
  users = [ "sven" "susven" ];
in
{
  # Create Dir
  environment.etc."skel".source = ../../skel/${config.networking.hostName};
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";

  # Copy items
  system.activationScripts = {
    copySkelDir = {
      text = ''
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            cp -rf /etc/skel/. /home/$user/ && touch /home/$user/.skel.lock
            chown -R $user:users /home/$user/
            chmod -R 755 /home/$user/
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          cp -rf /etc/skel/. /root/ && touch /root/.skel.lock
          chmod -R 755 /root/
        fi
      '';
      deps = [ ];
    };
  };
}
