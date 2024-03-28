{ lib, pkgs, config, home-manager, settings, ... }:

let
  mkUserConfig = name: user: {
    home.activation = lib.mkIf (if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false){
      configureFlatpak = ''
        ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
        ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
        ${pkgs.flatpak}/bin/flatpak override --user --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtkrc-2.0:ro --filesystem=xdg-config/gtk-4.0:ro --filesystem=xdg-config/gtkrc:ro --filesystem=~/.themes:ro
        ${pkgs.flatpak}/bin/flatpak override --user --device=dri --filesystem=~/Games:rw com.valvesoftware.Steam
        ${pkgs.rsync}/bin/rsync -vrkL /run/current-system/sw/share/themes/* ~/.themes/
      '';
    };
  };

  # Custom scripts
  prepare_spotify = pkgs.writeShellScriptBin "prepare_spotify" (builtins.readFile ./script/prepare_spotify.sh);
  prepare_discord = pkgs.writeShellScriptBin "prepare_discord" (builtins.replaceStrings ["@themeAccent@"] [ settings.theme.accent ](builtins.readFile ./script/prepare_discord.sh));
in
{
  # Install cusotm scripts
  environment.systemPackages = with pkgs; [
    # Theming
    (pkgs.writeShellScriptBin "spicetify" "exec -a $0 ${spicetify-cli}/bin/spicetify-cli $@")
    betterdiscordctl
    prepare_spotify
    prepare_discord
  ] ++ (if settings.de.name == "plasma" then [ pkgs.kdePackages.discover pkgs.kdePackages.packagekit-qt ] else []);

  # Install and enable flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Fix Icons and fonts for Flatpak
  #system.fsPackages = [ pkgs.bindfs ];
  #fileSystems = let
  #  mkRoSymBind = path: {
  #    device = path;
  #    fsType = "fuse.bindfs";
  #    options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
  #  };
  #  aggregatedFonts = pkgs.buildEnv {
  #    name = "system-fonts";
  #    paths = config.fonts.packages;
  #    pathsToLink = [ "/share/fonts" ];
  #  };
  #in {
  #  # Create an FHS mount to support flatpak host icons/fonts
  #  "/usr/share/icons" = mkRoSymBind "${config.system.path}/share/icons";
  #  "/usr/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
  #};

  # Add repo and add overrides for guiUsers
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users = lib.mapAttrs mkUserConfig settings.userAttrs;
}


