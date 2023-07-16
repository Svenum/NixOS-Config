{ pkgs, lib, ... }:

{
  home.file."autostart/solaar.desktop".source = lib.mkIf pkgs.solaar "${pkgs.solaar}/share/applications/solaar.desktop";
}
