{ pkgs, config, lib, ... }:

let
  cfg = config.flatpak;
in
{
  options.flatpak = {
    enable = mkEnableOption "Flatpak";
  };

  config = mkIf cfg.enable {

    # Enable Flatpak
    services.enable.flatpak = mkForce true;
    xdg.portal = mkForce {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };


  };
}
