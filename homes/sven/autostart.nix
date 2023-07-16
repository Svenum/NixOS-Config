{ pkgs, lib, ... }:

with lib;
{
  xdg.configFile."autostart/solaar.desktop".source = mkIf (pathExists "${pkgs.solaar}/share/applications/solaar.desktop") "${pkgs.solaar}/share/applications/solaar.desktop";
  xdg.configFile."autostart/brave.desktop".source = mkIf (pathExists "${pkgs.brave}/share/applications/solaar.desktop") "${pkgs.brave}/share/applications/solaar.desktop";
}
