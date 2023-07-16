{ pkgs, lib, ... }:

with lib;
{
  mkIf (pathExists "${pkgs.solaar}/share/applications/solaar.desktop") xdg.configFile."autostart/solaar.desktop".source = "${pkgs.solaar}/share/applications/solaar.desktop";
  mkIf (pathExists "${pkgs.brave}/share/applications/solaar.desktop") xdg.configFile."autostart/brave.desktop".source = "${pkgs.brave}/share/applications/solaar.desktop";
}
