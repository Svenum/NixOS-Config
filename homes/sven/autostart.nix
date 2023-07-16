{ pkgs, ... }:

{
  xdg.configFile."autostart/solaar.desktop".source = mkif pathExists "${pkgs.solaar}/share/applications/solaar.desktop" "${pkgs.solaar}/share/applications/solaar.desktop";
  xdg.configFile."autostart/brave.desktop".source = mkif pathExists "${pkgs.brave}/share/applications/solaar.desktop" "${pkgs.brave}/share/applications/solaar.desktop";
}
