{ home, pkgs, systemConfig, lib, settings, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};

  hostname = settings.networkConfig.hostName;
  enablePlasma = if systemConfig.networking.hostName != "Ni" then true else false;
  enableNixVirt = if hostname == "Ni" || hostname == "San" || hostname == "Shi" then true else false;
in
{
  imports = []
    ++ lib.optional enablePlasma ./plasma.nix
    ++ lib.optional enableNixVirt ./kvm.nix;

  # Add extgra packages
  home.packages = with pkgs; [
    caffeine-ng
    #tetris
    ccrypt
  ];

}
