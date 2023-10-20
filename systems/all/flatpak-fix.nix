{ config, pkgs, ... }:

{
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
    };
    aggregatedFonts = pkgs.buildEnv {
      name = "system-fonts";
      paths = config.fonts.packages;
      pathsToLink = [ "/share/fonts" ];
    };
    aggregatedThemes = pkgs.buildEnv {
      name = "system-themes";
      paths = with pkgs; [ catppuccin-gtk ];
      pathsToLink = [ "/share/themes" ];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    #"/usr/share/icons" = mkRoSymBind "${config.system.path}/share/icons";
    #"/usr/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
    "/usr/share/themes" = mkRoSymBind "${aggregatedThemes}/share/themes";
  };
}
