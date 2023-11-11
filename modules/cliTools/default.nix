{ pkgs, flatpak, ... }:

let
in
{
  environment = {
    systemPackages = with pkgs; [
      # CLI Packages
      git
      wget
      tree
      unzip
      pciutils
      clinfo
      killall
      neofetch
      cifs-utils
      btop
      dig
    ];
  };
}
