{ pkgs, ... }:
let
  users = [ "sven" "susven" ];
in
{
  # Create Dir
  environment.etc."skel".source = ../../skel;
  security.pam.makeHomeDir.skelDirectory = "/etc/skel";

  # Copy items
  system.userActivationScripts = {
    copySkelDir = {
      text = ''
        for user in ${toString users}; do
          if [ ! -f /home/$user/.skel.lock ]; then
            cp -r /etc/skel/* /home/$user/ && touch /home/$user/.skel.lock
            chmod -R 640 /home/$user/
          fi
        done
      '';
      deps = [ environment.etc ];
    };
  };
}
