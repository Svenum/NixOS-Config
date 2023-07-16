{ pkgs, ... }:

{
  home.file."autostart/solaar.desktop".source = builtins.elem pkgs.solaar environment.systemPackages "${pkgs.solaar}/share/applications/solaar.desktop";
}
