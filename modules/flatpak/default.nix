{ stdenv, pkgs, config, lib, ... }:

with lib;
let
  cfg = config.flatpak;
in
{
  options.flatpak = {
    enable = mkEnableOption "Flatpak";
    system = {
      enable = {
        types = mkBooleanOption;
        default = false;
      };
      repos = {
        types = types.Of types.str;
        default = [ "https://flathub.org/repo/flathub.flatpakrepo" ];
      };
      packages = {
        types = types.Of types.str;
        default = [];
      };
    };
  };

  config = mkIf cfg.enable{

    # Enable Flatpak
    services.flatpak.enable = mkForce true;
    xdg.portal = mkForce {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    };
  };
}
