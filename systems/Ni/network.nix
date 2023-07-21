{ lib, ... }:

{
  networking = {
    hostName = "Ni";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
