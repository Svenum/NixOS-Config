{ pkgs, ... }:

{
  home.file."autostart/solaar.desktop".source = "${pkgs.solaar}/share/applications/solaar.desktop";
}
