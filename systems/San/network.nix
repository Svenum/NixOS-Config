{ lib, ... }:

{
  networking = {
    hostName = "San";
    networkmanager.enable = true;
    useDHCP = false;
  };
}
