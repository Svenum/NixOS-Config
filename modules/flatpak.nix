{ lib, pkgs, config, home, ... }:
with lib;

let
  flatpakPackages = config.flatpak.packages;
in
{
  options.flatpak = {
    packages = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
  
  config = {
    home.activation = {
      addFlatpakRemots = ''
        #!/usr/bin/env bash
        ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
      installFlatpakPackages = ''
        #!/usr/bin/env bash
        ${pkgs.flatpak}/bin/flatpak --user ${if (length flatpakPackages > 0) then "install ${toString flatpakPackages}" else "remove --all"} -y
      '';
    };
  };
}
