{ pkgs, lib, builtins, ... }:

with lib;
{
  xdg.configFile."autostart/solaar.desktop".source = mkIf builtins.pathExists "${pkgs.solaar}/share/applications/solaar.desktop" "${pkgs.solaar}/share/applications/solaar.desktop";
  xdg.configFile."autostart/brave.desktop".source = mkIf builtins.pathExists "${pkgs.brave}/share/applications/solaar.desktop" "${pkgs.brave}/share/applications/solaar.desktop";
}
