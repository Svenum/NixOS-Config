{ networkConfig, lib, ... }:

let
  static = if builtins.hasAttr "useDHCP" networkConfig then !networkConfig.useDHCP else true;
  dynamic = if builtins.hasAttr "useDHCP" networkConfig then networkConfig.useDHCP else false;
in
{
  networking = {
    hostName = networkConfig.hostName;
    networkmanager = {
      enable = true;
    };
    interfaces = lib.mkIf static {
      ${networkConfig.interface}.ipv4.addresses = [{
        address = networkConfig.address;
        prefixLength = networkConfig.prefixLength;
      }];
    };
    defaultGateway = lib.mkIf static networkConfig.defaultGateway;
    nameservers = lib.mkIf static networkConfig.nameservers;
    useDHCP = lib.mkDefault false;
  };
}
