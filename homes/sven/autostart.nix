{ pkgs, ... }:

{
  xdg.configFile."autostart/solaar.desktop".source = "${pkgs.solaar}/share/applications/solaar.desktop";
  xdg.configFile."autostart/brave.desktop".source = "${pkgs.brave}/share/applications/solaar.desktop";
}
