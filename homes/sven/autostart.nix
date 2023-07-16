{ pkgs, lib, ... }:

with lib;
let
  app_list_full = [ "brave" "solaar" ];
  app_list_final = mapAttrs (name: item:
    (if (pathExists "${pkgs.${item}}/share/applications/${item}.desktop") then
      "autostart/${item}.desktop.source" = "${pkgs.${item}}/share/applications/${item}.desktop");
    )
  );
  
in
{
  xdg.configFile = {
    app_list_final;
  }
}

