{ home-manager, user, lib, ... }:

{
  import home-manager.nixosModules.home-manager;
  home-manager.users = lib.mkIf user.gui ? false {
    ${user.name} = {
      home.activation = {
        configureFlatpak = ''
          ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
          ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
          ${pkgs.flatpak}/bin/flatpak override --user --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtkrc:ro --filesystem=~/.themes:ro
          ${pkgs.flatpak}/bin/flatpak override --user --device=dri --filesystem=~/Games:rw com.valvesoftware.Steam
        '';
      };
    };
  };
}
