{ lib, ... }:

{
  networking = {
    hostName = "San";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
