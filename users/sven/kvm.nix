{ nixVirt, systemConfig, ... }:

{
  # import home-manager module
  imports = [ nixVirt.homeModules.default ];

  virtualisation.libvirt.connections."qemu:///session" = {
    # Add isos pool
    pools = [
      {
        definition = nixvirt.lib.pool.writeXML {
          name = "isos";
          path = "/home/sven/.local/share/libvirt/isos";
        };
      }
    ];
    # Add windows Domain
    #domains = [
    #  (
    #    lib.mkIf (systemConfig.networking.hostName == "Shi")
    #    {
    #      definition = nixvirt.lib.pool.writeXML {
    #        vcpu.count = 12;
    #        os = 
    #      };
    #    }
    #  )
    #]
  };
}
