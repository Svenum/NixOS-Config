{ settings, lib, ... }:

let
  static = if builtins.hasAttr "useDHCP" settings.networkConfig then !settings.networkConfig.useDHCP else true;
  dynamic = if builtins.hasAttr "useDHCP" settings.networkConfig then settings.networkConfig.useDHCP else false;
in
{
  networking = {
    hostName = settings.networkConfig.hostName;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless = {
      iwd.enable = true;
      dbusControlled = true;
    };
    interfaces = lib.mkIf static {
      ${settings.networkConfig.interface}.ipv4.addresses = [{
        address = settings.networkConfig.address;
        prefixLength = settings.networkConfig.prefixLength;
      }];
    };
    defaultGateway = lib.mkIf static settings.networkConfig.defaultGateway;
    nameservers = lib.mkIf static settings.networkConfig.nameservers;
    useDHCP = lib.mkDefault false;
  };
}
