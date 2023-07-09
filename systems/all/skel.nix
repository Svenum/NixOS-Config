{ pkgs, ... }:
let
  users = [ "sven" "susven" ];
in
{
  # Create Dir
  environment.etc."skel".source = ../../skel;
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";

  # Copy items
  system.activationScripts = {
    copySkelDir = {
      text = ''
        message="If this file is deleted the next reboot or nixos-rebuild will override some config files!"
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            cp -r /etc/skel/. /home/$user/ && echo $message > /home/$user/.skel.lock
            chown -R $user:users /home/$user/
            chmod -R 755 /home/$user/
          fi
        done
        if [ ! -f /root/.skel.lock ]; then
          cp -r /etc/skel/. /root/ && echo $message > /root/.skel.lock
          chmod -R 755 /root/
        fi
      '';
      deps = [ ];
    };
  };
}
