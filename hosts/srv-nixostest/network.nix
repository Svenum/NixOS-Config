{ ... }:

{
  networking = {
    hostName = "srv-nixostest";
    networkmanager.enable = true;
    interfaces.enp1s0.ipv4.addresses = [{
      address = "172.16.0.111";
      prefixLength = 24;
    }];
    defaultGateway = "172.16.0.1";
    nameservers = [ "172.16.0.3" "172.16.0.4" ];
  };
}
