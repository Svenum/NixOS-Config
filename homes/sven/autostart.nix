{ pkgs, config, ... }:

{
  home.file."autostart/solaar.desktop".source = builtins.elem pkgs.solaar config.environment.systemPackages "${pkgs.solaar}/share/applications/solaar.desktop";
}
